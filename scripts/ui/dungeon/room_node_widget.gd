class_name RoomNodeWidget
extends Control

enum RoomState {UNAVAILABLE, AVAILABLE, TAKEN}

const HIGHLIGHT_SCALE = 0.6
const TAKEN_SCALE = 0.5
const AVAILABLE_SCALE = 0.85
const NOT_TAKEN_SCALE = 0.5
const BOSS_SCALE = 1.1
const CIRCLE_START_SCALE = 2.0
const CIRCLE_END_SCALE = 1.3
const HOVER_SOUNDS: Array = ["MAP_HOVER_1", "MAP_HOVER_2", "MAP_HOVER_3", "MAP_HOVER_4"]
const SELECT_SOUNDS: Array = ["MAP_SELECT_1", "MAP_SELECT_2", "MAP_SELECT_3", "MAP_SELECT_4"]
signal clicked(room_node: MapRoomNode)

static var TAKEN_COLOR: Color = Color(0.09, 0.13, 0.17, 1.0)
static var NOT_TAKEN_COLOR: Color = Color(0.34, 0.34, 0.34, 1.0)
static var AVAILABLE_COLOR: Color = Color(0.09, 0.13, 0.17, 1.0)
static var JITTER: Vector2 = Vector2(17, 17)
static var OUTLINE_COLOR: Color = Color.hex(0x8c8c80ff)
@export var input_container: Control
@export var img_outline: Sprite2D
@export var img: Sprite2D
@export var circle_anim_player: AnimatedSprite2D

var state: RoomState = RoomState.UNAVAILABLE
var room_node: MapRoomNode
var jitter_offset: Vector2 = Vector2.ZERO
var edge_widgets: Array[EdgeWidget] = []
var oscillate_timer: float = 0.0

var target_scale_amount: float = NOT_TAKEN_SCALE
var highlight: bool = false
var is_boss: bool = false

var available_scale: float = 1.0
var not_taken_scale: float = 1.0

var start_tick: bool = false
var click_timer: float = 0.0

@onready var info_label: Label = $Info
func _ready() -> void:
	circle_anim_player.stop()
	circle_anim_player.frame = 0
	circle_anim_player.visible = false

	circle_anim_player.rotation_degrees = randf_range(0, 360)

	jitter_offset.x = randf_range(-JITTER.x, JITTER.x)
	jitter_offset.y = randf_range(-JITTER.y, JITTER.y)
	img_outline.modulate.a = 0

	input_container.mouse_entered.connect(_on_mouse_entered)
	input_container.mouse_exited.connect(_on_mouse_exited)
	input_container.gui_input.connect(_on_gui_input)
	oscillate_timer = randf_range(0, 6.28)
	if info_label:
		info_label.queue_free()

func _process(delta: float) -> void:
	if not highlight:
		if state == RoomState.AVAILABLE:
			oscillate_timer += delta * 5
			img.modulate.a = 0.66 + (cos(oscillate_timer) + 1) / 6.0
			scale = Vector2i.ONE * (BOSS_SCALE if is_boss else img.modulate.a)
		else:
			# if state == RoomState.TAKEN:
			# 	img_outline.modulate.a = MathHelper.lerp_snap(img_outline.modulate.a, 0, delta * 10)
			img.modulate.a = 1.0
			var cur_scale_amount = scale.x
			cur_scale_amount = MathHelper.lerp_snap(cur_scale_amount, target_scale_amount, delta * 7)
			scale = Vector2i.ONE * cur_scale_amount

			var circle_cur_scale_amount = circle_anim_player.scale.x
			circle_cur_scale_amount = MathHelper.lerp_snap(circle_cur_scale_amount, CIRCLE_END_SCALE, delta * 7)
			circle_anim_player.scale = Vector2.ONE * circle_cur_scale_amount
			

func load_room_node(_room_node: MapRoomNode) -> void:
	room_node = _room_node
	name = AbstractRoom.RoomType.find_key(room_node.room.type) + "_[" + str(room_node.x) + "," + str(room_node.y) + "]"
	img_outline.texture = _room_node.room.map_img_outline
	img.texture = _room_node.room.map_img
	is_boss = room_node.room.type == AbstractRoom.RoomType.BOSS
	
	input_container.size = Vector2(400, 400) if is_boss else img.texture.get_size()
	input_container.position = - input_container.size / 2

	set_room_state(RoomState.UNAVAILABLE, true, true)
	set_edges_active(false)
	# pivot_offset = size / 2
	# var coord_info: String = "({0}, {1})".format([_room_node.x, _room_node.y])
	# var parent_info: String = "parent:"
	# for parent in room_node.parents:
	# 	parent_info += "({0}, {1}) ".format([parent.x, parent.y])
	# var edge_info: String = "next: "
	# for edge in room_node.edge_widgets:
	# 	edge_info += "({0}, {1}) ".format([edge.dst.x, edge.dst.y])
	# info_label.text = coord_info + "\n" + parent_info + "\n" + edge_info
func dispose() -> void:
	edge_widgets.clear()
	

func set_highlight(_highlight: bool) -> void:
	highlight = _highlight
	if highlight:
		img.modulate = AVAILABLE_COLOR
		img_outline.modulate.a = 1
		set_node_scale(HIGHLIGHT_SCALE, true)
	else:
		img_outline.modulate.a = 0
		match state:
			RoomState.TAKEN:
				set_node_scale(TAKEN_SCALE)
				img.modulate = TAKEN_COLOR
			RoomState.AVAILABLE:
				img.modulate = AVAILABLE_COLOR
			RoomState.UNAVAILABLE:
				set_node_scale(get_not_taken_scale(is_boss))
				img.modulate = NOT_TAKEN_COLOR
func set_node_scale(scale_amount: float, instant: bool = false) -> void:
	target_scale_amount = scale_amount
	if instant:
		scale = Vector2(scale_amount, scale_amount)

func set_room_state(_state: RoomState, instant: bool = false, force: bool = false) -> void:
	if not force and state == _state:
		return
	state = _state
	match state:
		RoomState.TAKEN:
			set_node_scale(get_taken_scale(is_boss), true if is_boss else instant)
			img.modulate = TAKEN_COLOR
			img_outline.modulate.a = 0
			if not is_boss:
				circle_anim_player.visible = true
				circle_anim_player.sprite_frames.set_animation_loop("default", false)
				circle_anim_player.stop()
				circle_anim_player.play("default")
				circle_anim_player.modulate = TAKEN_COLOR
				circle_anim_player.scale = Vector2.ONE * CIRCLE_START_SCALE
			play_select_sound()
		RoomState.AVAILABLE:
			img.modulate = AVAILABLE_COLOR
		RoomState.UNAVAILABLE:
			set_node_scale(get_not_taken_scale(is_boss), instant)
			img.modulate = NOT_TAKEN_COLOR

func set_edges_active(active: bool) -> void:
	for edge in edge_widgets:
		edge.modulate = AVAILABLE_COLOR if active else NOT_TAKEN_COLOR

func bind_edge_widget(_edge_widget: EdgeWidget) -> void:
	_edge_widget.modulate = AVAILABLE_COLOR if state == RoomState.TAKEN else NOT_TAKEN_COLOR
	edge_widgets.append(_edge_widget)

func get_actual_position() -> Vector2:
	return position + pivot_offset


func _on_gui_input(event: InputEvent) -> void:
	if state != RoomState.AVAILABLE:
		return
	if event is InputEventMouseButton:
		var button_event = event as InputEventMouseButton
		if button_event.button_index == MOUSE_BUTTON_LEFT:
			if button_event.is_pressed():
				click_timer = Time.get_ticks_msec()
			elif button_event.is_released():
				if Time.get_ticks_msec() - click_timer < 250:
					clicked.emit(self)


func _on_mouse_entered() -> void:
	match state:
		RoomState.TAKEN:
			pass
		RoomState.AVAILABLE:
			img_outline.modulate.a = 1
			play_hover_sound()
		RoomState.UNAVAILABLE:
			set_node_scale(get_available_scale(is_boss), true)
			img.modulate = AVAILABLE_COLOR
	# print("node info: ")
	# print("room type: ", AbstractRoom.RoomType.find_key(room_node.room.type))
	# print(("x: {0}, y: {1}").format([room_node.x, room_node.y]))
	# print("edge count: ", room_node.edge_widgets.size())
	# for edge in room_node.edge_widgets:
	# 	print("edge: ({0}, {1}) -> ({2}, {3})".format([edge.src.x, edge.src.y, edge.dst.x, edge.dst.y]))
func _on_mouse_exited() -> void:
	match state:
		RoomState.TAKEN:
			pass
		RoomState.AVAILABLE:
			img_outline.modulate.a = 0
		RoomState.UNAVAILABLE:
			set_node_scale(get_not_taken_scale(is_boss))
			img.modulate = NOT_TAKEN_COLOR

func play_hover_sound() -> void:
	var roll = randi_range(0, 3)
	CardGame.sound.single_play(HOVER_SOUNDS[roll])


func play_select_sound() -> void:
	var roll = randi_range(0, 3)
	CardGame.sound.single_play(SELECT_SOUNDS[roll])

static func get_available_scale(_is_boss: bool) -> float:
	return BOSS_SCALE if _is_boss else AVAILABLE_SCALE

static func get_taken_scale(_is_boss: bool) -> float:
	return BOSS_SCALE if _is_boss else TAKEN_SCALE

static func get_not_taken_scale(_is_boss: bool) -> float:
	return BOSS_SCALE if _is_boss else NOT_TAKEN_SCALE
