# @tool
class_name DungeonMapScreen
extends Control

const MAP_DST_Y: float = 150
const CLICK_TIME: float = 0.25
const SCROLL_WAIT_TIME: float = 1.0
const SCROLL_ANIM_TIME: float = 3.0
const MAP_UPPER_SCROLL_DEFAULT: float = -2500.0
const MAP_UPPER_SCROLL_ENDING: float = -300.0
const MAP_SCROLL_UPPER: float = 0.0

const MAP_HEIGHT: float = 1050
const MAP_OFFSET_Y: float = 350

const NODE_OFFSET: Vector2 = Vector2(600, 3200)

static var SPACING_X: float = 128

static var room_node_prefab: PackedScene = null
static var room_node_pool: Array[RoomNodeWidget] = []
static var ui_string: UIString = null
static var TEXT: Array

static func initialize() -> void:
	ui_string = CardGame.languagePack.get_ui_string("DungeonMapScreen")
	TEXT = ui_string.TEXT

	room_node_prefab = load("res://scenes/slay_the_spire/rooms/room_node.tscn")

@export_group("Map")
@export var manual: bool = false
@export_range(0, 1) var slider: float = 0
@export var top: Sprite2D
@export var mid: Sprite2D
@export var bot: Sprite2D
@export var blend1: Sprite2D
@export var blend2: Sprite2D
@export var legend: Legend
@export_group("")

@export_group("Room")
@export var container: Control = null
@export var room_container: Control = null
@export var edge_container: Control = null
@export_group("")

var dungeon: AbstractDungeons = null
# scroll animation
var anim_scroll_wait_timer: float = 0
var scroll_back_timer: float = 0

var map_scroll_lower_limit: float
var offset_y: float = -100
var target_offset_y: float = offset_y

# map
var visible_room_node_widgets: Array[RoomNodeWidget] = []
var room_node_widget_dict: Dictionary[MapRoomNode, RoomNodeWidget] = {}
var room_widgets_by_room_type: Dictionary = {}
var boss_room_widget: RoomNodeWidget = null
var cur_room_node: MapRoomNode = null
var map_alpha: float = 1.0
var map_mid_dist: float = 0.0
var is_ending: bool = false
# mouse
var grabbed_screen: bool = false
var grabbed_start_y: float = 0

var pre_room_phase: AbstractRoom.RoomPhase = AbstractRoom.RoomPhase.INCOMPLETE
var cur_available_room_widgets: Array[RoomNodeWidget] = []
@onready var map_bg = $MapBG

func _ready() -> void:
	if container == null:
		container = $Container
	if room_container == null:
		room_container = $Container/RoomContainer
	if edge_container == null:
		edge_container = $Container/EdgeContainer
	legend.on_item_mouse_entered = on_legend_item_mouse_entered
	legend.on_item_mouse_exited = on_legend_item_mouse_exited
	
func _process(delta: float) -> void:
	_update_scrolling_animation(delta)
	_update_map_position(delta)
	_update_node_state(delta)
	

func load_map(_dungeon: AbstractDungeons) -> void:
	dungeon = _dungeon
	for widget in visible_room_node_widgets:
		recycle(widget)
	visible_room_node_widgets.clear()
	
	for row in dungeon.map:
		for node: MapRoomNode in row:
			if node.has_edges():
				var widget: RoomNodeWidget = allocate(node, room_container)
				widget.position = widget.jitter_offset + calc_node_pos(node.x, node.y)
				visible_room_node_widgets.append(widget)
				room_node_widget_dict[node] = widget
				if room_widgets_by_room_type.has(node.room.type):
					room_widgets_by_room_type[node.room.type].append(widget)
				else:
					room_widgets_by_room_type[node.room.type] = [widget]
	
	boss_room_widget = allocate(dungeon.boss_room_node, room_container)
	boss_room_widget.position = calc_node_pos(dungeon.boss_room_node.x, dungeon.boss_room_node.y)
	visible_room_node_widgets.append(boss_room_widget)
	room_node_widget_dict[dungeon.boss_room_node] = boss_room_widget
	
	# generate edge
	for dst_widget: RoomNodeWidget in visible_room_node_widgets:
		for parent: MapRoomNode in dst_widget.room_node.parents:
			var is_boss: bool = dst_widget.room_node.room.type == AbstractRoom.RoomType.BOSS
			var src_widget: RoomNodeWidget = room_node_widget_dict[parent]
			var edge_widget = EdgeWidget.new()
			edge_container.add_child(edge_widget)
			src_widget.bind_edge_widget(edge_widget)
			edge_widget.name = src_widget.name + "_to_" + dst_widget.name
			edge_widget.set_endpoints(src_widget, dst_widget, is_boss)


	set_cur_room_node(dungeon.init_map_node)
func open(play_scroll_animation: bool = false) -> void:
	visible = true
	is_ending = CardGame.cur_dungeon.id == TheEnding.ID
	show_map()

	if play_scroll_animation:
		anim_scroll_wait_timer = 4.0
		offset_y = MAP_SCROLL_UPPER
		target_offset_y = map_scroll_lower_limit
	else:
		anim_scroll_wait_timer = 0
		offset_y = map_scroll_lower_limit
		target_offset_y = offset_y
		
func close() -> void:
	visible = false
	hide_map()

func show_map() -> void:
	map_alpha = 1.0
	if is_ending:
		map_scroll_lower_limit = MAP_UPPER_SCROLL_ENDING
		map_mid_dist = -780
	else:
		map_scroll_lower_limit = MAP_UPPER_SCROLL_DEFAULT
		map_mid_dist = 1020

func hide_map(instant: bool = false) -> void:
	map_alpha = 0.0
	if instant:
		map_bg.modulate.a = 0

func is_anim_scrolling() -> bool:
	return anim_scroll_wait_timer >= 0

func can_scroll_map() -> bool:
	return not is_anim_scrolling()

func get_into_room(widget: RoomNodeWidget) -> void:
	# widget.set_room_state(RoomNodeWidget.RoomState.TAKEN)
	set_cur_room_node(widget.room_node)

##################################
# node function
##################################
func set_cur_room_node(_node: MapRoomNode) -> void:
	cur_room_node = _node
	var row = cur_room_node.y
	if row != -1:
		var cur_widget: RoomNodeWidget = room_node_widget_dict[cur_room_node]
		cur_widget.set_room_state(RoomNodeWidget.RoomState.TAKEN)
	pre_room_phase = AbstractRoom.RoomPhase.NONE
var wait_timer: float = 0
func _update_node_state(_delta: float):
	if Engine.is_editor_hint():
		return
	if dungeon == null:
		return
	if pre_room_phase != cur_room_node.room.phase:
		match cur_room_node.room.phase:
			AbstractRoom.RoomPhase.COMBAT:
				print("in combat...")
				wait_timer = 1.0
				# CardGame.dungeon_main_screen.open_screen(DungeonMainScreen.ScreenType.COMBAT)
			AbstractRoom.RoomPhase.EVENT:
				print("in event...")
				wait_timer = 1.0
			AbstractRoom.RoomPhase.INCOMPLETE:
				print("in incomplete...")
				wait_timer = 1.0
			AbstractRoom.RoomPhase.COMPLETE:
				print("in complete...")
				cur_available_room_widgets.clear()
				var row = cur_room_node.y
				if row != -1:
					var cur_widget: RoomNodeWidget = room_node_widget_dict[cur_room_node]
					cur_widget.set_edges_active(true)
				for edge in cur_room_node.edges:
					var widget: RoomNodeWidget = null
					if edge.dst.y > dungeon.map.size():
						widget = boss_room_widget
					else:
						var next_node: MapRoomNode = dungeon.map[edge.dst.y][edge.dst.x]
						widget = room_node_widget_dict[next_node]
					widget.set_room_state(RoomNodeWidget.RoomState.AVAILABLE)
					cur_available_room_widgets.append(widget)
	
	pre_room_phase = cur_room_node.room.phase
	if cur_room_node.room.phase != AbstractRoom.RoomPhase.COMPLETE:
		wait_timer -= _delta
		if wait_timer < 0:
			print("invoke")
			cur_room_node.room.phase = AbstractRoom.RoomPhase.COMPLETE

##################################
# map function
##################################
func _update_scrolling_animation(delta: float) -> void:
	if manual or Engine.is_editor_hint():
		offset_y = MathHelper.lerp_snap(MAP_UPPER_SCROLL_DEFAULT, MAP_SCROLL_UPPER, slider)
		return
	if target_offset_y < map_scroll_lower_limit:
		target_offset_y = MathHelper.lerp_snap(target_offset_y, map_scroll_lower_limit, delta * 10)
	elif target_offset_y > MAP_SCROLL_UPPER:
		target_offset_y = MathHelper.lerp_snap(target_offset_y, MAP_SCROLL_UPPER, delta * 10)

	if is_anim_scrolling():
		anim_scroll_wait_timer -= delta
		if anim_scroll_wait_timer < 3:
			offset_y = CardGame.interpolation.apply_exp10(map_scroll_lower_limit, MAP_SCROLL_UPPER, anim_scroll_wait_timer / 3.0)
	else:
		offset_y = MathHelper.lerp_snap(offset_y, target_offset_y, delta * 12)

func _update_map_position(delta: float) -> void:
	# update bg
	if manual or Engine.is_editor_hint():
		top.position = Vector2(0, offset_y + MAP_OFFSET_Y)
		mid.position = Vector2(0, MAP_HEIGHT + offset_y + MAP_OFFSET_Y)
		bot.position = Vector2(0, MAP_HEIGHT + MAP_HEIGHT + offset_y + MAP_OFFSET_Y + 1.0)
		blend1.position = Vector2(0, offset_y + MAP_OFFSET_Y + 800)
		blend2.position = Vector2(0, offset_y + MAP_OFFSET_Y + 1890)
		return
	
	map_bg.modulate.a = MathHelper.lerp_snap(map_bg.modulate.a, map_alpha, delta * 12)
	
	top.position = Vector2(0, offset_y + MAP_OFFSET_Y)
	mid.position = Vector2(0, MAP_HEIGHT + offset_y + MAP_OFFSET_Y)
	bot.position = Vector2(0, MAP_HEIGHT + map_mid_dist + offset_y + MAP_OFFSET_Y + 1.0)
	blend1.position = Vector2(0, offset_y + MAP_OFFSET_Y + 800)
	blend2.position = Vector2(0, offset_y + MAP_OFFSET_Y + 1890)
	
	container.position = Vector2(0, offset_y)
##################################
# event function
##################################
func _on_room_node_clicked(target_widget: RoomNodeWidget):
	for widget in cur_available_room_widgets:
		if widget == target_widget:
			get_into_room(widget)
		else:
			widget.set_room_state(RoomNodeWidget.RoomState.UNAVAILABLE)


func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		if event is InputEventMouseButton:
			var input_event = event as InputEventMouseButton
			if can_scroll_map():
				if input_event.button_index == MOUSE_BUTTON_WHEEL_UP:
					target_offset_y += Settings.SCROLL_SPEED
				elif input_event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
					target_offset_y -= Settings.SCROLL_SPEED
				elif input_event.button_index == MOUSE_BUTTON_LEFT:
					if input_event.is_pressed():
						grabbed_screen = true
						grabbed_start_y = input_event.position.y - target_offset_y
					if input_event.is_released():
						grabbed_screen = false
		elif event is InputEventMouseMotion:
			var input_event = event as InputEventMouseMotion
			if can_scroll_map():
				if grabbed_screen:
					target_offset_y = input_event.position.y - grabbed_start_y
				else:
					grabbed_screen = false


func on_legend_item_mouse_entered(item: LegendItem) -> void:
	for widget in room_widgets_by_room_type[item.type]:
		widget.set_highlight(true)
func on_legend_item_mouse_exited(item: LegendItem) -> void:
	for widget in room_widgets_by_room_type[item.type]:
		widget.set_highlight(false)

##################################
# pool function
##################################
func allocate(node: MapRoomNode, parent: Control) -> RoomNodeWidget:
	var widget: RoomNodeWidget
	if room_node_pool.is_empty():
		widget = room_node_prefab.instantiate() as RoomNodeWidget
	else:
		widget = room_node_pool.pop_front()

	parent.add_child(widget)
	widget.process_mode = Node.PROCESS_MODE_INHERIT
	widget.show()
	widget.load_room_node(node)
	widget.clicked.connect(_on_room_node_clicked)
	return widget

func recycle(widget: RoomNodeWidget) -> void:
	if widget == null:
		return
	widget.get_parent().remove_child(widget)
	widget.dispose()
	room_node_pool.push_back(widget)
	widget.process_mode = Node.PROCESS_MODE_DISABLED
	widget.hide()
	for connect_dic in widget.clicked.get_connections():
		if widget.clicked.is_connected(connect_dic["callable"]):
			widget.clicked.disconnect(connect_dic["callable"])


static func calc_node_pos(x: int, y: int) -> Vector2:
	return NODE_OFFSET + Vector2(x * SPACING_X, -y * MAP_DST_Y)
