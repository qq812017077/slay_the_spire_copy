class_name HandPanel
extends AbstractPanel

const HOVER_CARD_POS: float = Settings.DEFAULT_HEIGHT - 50.0
var CARD_X_COORD_TABLE: Dictionary = {}
var CARD_Y_OFFSET_TABLE: Dictionary = {}

@export var arrow_container: Control = null
@export var arrows: Array[Sprite2D] = []
var is_hovering_drop_zone: bool = false

var hand_card_widgets: Array[CardWidget] = []
var hovered_card: CardWidget = null
var is_hovering_card: bool = false

var dragging_card: CardWidget = null
var is_dragging_card: bool = false
var is_single_target_mode: bool = false

# arrow
var arrow_points: PackedVector2Array = PackedVector2Array(
	[Vector2(0, 0), Vector2(0, 0), Vector2(0, 0), Vector2(0, 0), Vector2(0, 0),
	Vector2(0, 0), Vector2(0, 0), Vector2(0, 0), Vector2(0, 0), Vector2(0, 0),
	Vector2(0, 0), Vector2(0, 0), Vector2(0, 0), Vector2(0, 0), Vector2(0, 0),
	Vector2(0, 0), Vector2(0, 0), Vector2(0, 0), Vector2(0, 0), Vector2(0, 0)])
var target_arrow_pos: Vector2 = Vector2.ZERO

func _ready() -> void:
	build_pos_table()
	build_arrow()

func update(delta: float) -> void:
	var cur_hovered_card: CardWidget = null
	var cur_hovering_card: bool = false
	for card in hand_card_widgets:
		card.update_position(delta)
		card.update_angle(delta)
		card.update_scale(delta)
	
		if is_dragging_card:
			continue
		
		if card.is_hovering():
			card.z_index = 1
		else:
			card.z_index = 0
		if not cur_hovering_card and card.is_hovering():
			cur_hovered_card = card
			cur_hovering_card = true
	
	if is_dragging_card:
		update_dragging_card(delta)
	else:
		var changed: bool = cur_hovering_card != is_hovering_card or cur_hovered_card != hovered_card
		
		if changed:
			refresh_layout()
			if cur_hovering_card:
				cur_hovered_card.set_target_pos_y(HOVER_CARD_POS - cur_hovered_card.size.y, true)
				cur_hovered_card.set_target_angle(0.0, true)
				cur_hovered_card.set_target_scale(1.3333, true)
				hover_card_push(cur_hovered_card)
		hovered_card = cur_hovered_card
		is_hovering_card = cur_hovering_card


func update_dragging_card(delta: float) -> void:
	if is_single_target_mode:
		render_targeting_ui(delta)
	else:
		var target_card_pos: Vector2 = get_local_mouse_position() - dragging_card.size / 2.0
		if is_hovering_drop_zone:
			if dragging_card.card.target == AbstractCard.CardTarget.ENEMY or dragging_card.card.target == AbstractCard.CardTarget.SELF_AND_ENEMY:
				is_single_target_mode = true
				arrow_container.visible = true
				target_card_pos = Vector2(Settings.WIDTH / 2.0, Settings.HEIGHT - AbstractCard.IMG_HEIGHT * 0.75 / 2.5)

		dragging_card.set_target_pos(target_card_pos)
	
	
	dragging_card.update_position(delta)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if is_dragging_card:
			var y: float = event.global_position.y
			is_hovering_drop_zone = y < (Settings.DEFAULT_HEIGHT - 250.0) * Settings.scale and y > 0.0
	elif event is InputEventMouseButton:
		var mouse_event: InputEventMouseButton = event as InputEventMouseButton
		if mouse_event.button_index != MOUSE_BUTTON_LEFT and mouse_event.button_index != MOUSE_BUTTON_RIGHT:
			return
		elif is_dragging_card:
			if mouse_event.button_index ==  MOUSE_BUTTON_RIGHT:
				release_card()
				return 
		if mouse_event.is_pressed():
			_on_hand_panel_clicked(mouse_event)
			# print("mouse pressed ",mouse_event.button_index)

func _on_hand_panel_clicked(mouse_event: InputEventMouseButton) -> void:
	for card in hand_card_widgets:
		# check if mouse is inside card
		# print("check card:", card.name, " z_index:", card.z_index, " has point:", card.get_global_rect().has_point(mouse_event.global_position))
		if card.z_index == 1 and card.get_global_rect().has_point(mouse_event.global_position):
			_on_card_clicked(card)
			if not is_dragging_card:
				# tranverse all card from right to left.
				for i in range(hand_card_widgets.size() - 1, -1, -1):
					if hand_card_widgets[i] == card:
						card.refresh_card_state_once(0.25)
					elif hand_card_widgets[i].get_global_rect().has_point(mouse_event.global_position):
						hand_card_widgets[i].set_card_hover()
						break
			break

func add_to_hand(card: CardWidget) -> void:
	# card.on_card_clicked = _on_card_clicked
	hand_card_widgets.append(card)

func on_combat_start() -> void:
	for widget: CardWidget in hand_card_widgets:
		CardWidget.recycle(widget)
	
	hand_card_widgets.clear()

func release_card() -> void:
	# if hovered_card != null:
	# 	if hovered_card.card.can_use(player, null):
	#		hovered_card.begin_glow()
		
	# 	hovered_card.hover_timer = 0.25
	arrow_container.visible = false
	is_dragging_card = false
	is_single_target_mode = false
	CardGame.mouse_cursor.show_cursor()
	dragging_card.set_card_waited()
	dragging_card.z_index = 0
	dragging_card = null
	refresh_layout()

func _on_card_clicked(card: CardWidget) -> void:
	if hovered_card != card:
		return
	
	# if is hovered card, select or release it
	if is_dragging_card:
		release_card()
		# refresh all cards' state after 0.25 second
		# for card_widget: CardWidget in hand_card_widgets:
		# 	card_widget.refresh_card_state_once(0.25 if card_widget == card else 0.01)
	else:
		is_dragging_card = true
		dragging_card = card
		dragging_card.set_target_angle(0.0, true)
		dragging_card.set_target_scale(1.3333, true)
		target_arrow_pos = dragging_card.get_center_position()
		draw_curved_line(target_arrow_pos, target_arrow_pos)
		CardGame.mouse_cursor.hide_cursor()


func hover_card_push(card: CardWidget) -> void:
	var hand_card_count: int = hand_card_widgets.size()
	if hand_card_count < 2:
		return
	
	var card_num: int = -1
	for i: int in range(hand_card_count):
		if hand_card_widgets[i] == card:
			card_num = i
			break
	
	var push_amt: float = 0.4
	if hand_card_count == 2:
		push_amt = 0.2
	elif hand_card_count == 3 or hand_card_count == 4:
		push_amt = 0.27
	
	var left_push_amt: float = push_amt
	var right_push_amt: float = push_amt

	var right_slot: int = card_num + 1
	var left_slot: int = card_num - 1
	while right_slot < hand_card_count:
		hand_card_widgets[right_slot].target_pos.x += AbstractCard.IMG_WIDTH_S * right_push_amt
		right_push_amt *= 0.25
		right_slot += 1
	
	while left_slot >= 0 and left_slot < hand_card_count:
		hand_card_widgets[left_slot].target_pos.x -= AbstractCard.IMG_WIDTH_S * left_push_amt
		left_push_amt *= 0.25
		left_slot -= 1

# func reset_card_before_moving(card: CardWidget) -> void:
# 	if hovered_card == card:
# 		release_card()

# 	# card.
# 	card.stop_glow()


# 
func refresh_layout() -> void:
	for relic: AbstractRelic in player.relics:
		relic.on_refresh_hand()
	
	var hand_group_size: int = player.hand.group.size()
	var angle_range: float = 50.0 - (10 - hand_group_size) * 5.0
	var increment_angle: float = angle_range / hand_group_size
	var sink_start: float = 80.0
	var sink_range: float = 300.0
	var increment_sink: float = sink_range / hand_group_size / 2.0
	var middle: int = int(hand_group_size / 2.0)

	var even_count: bool = hand_group_size % 2 == 0
	for i: int in range(hand_group_size):
		hand_card_widgets[i].set_target_angle(increment_angle * i + increment_angle / 2.0 - angle_range / 2.0)
		hand_card_widgets[i].set_target_scale(1.0)
		var t: int = i - middle
		
		if t >= 0:
			if even_count:
				t += 1
			t = -t
		
		if even_count:
			t += 1
		t = int(t * 1.7)

		var target_y: float = Settings.DEFAULT_HEIGHT - sink_start - increment_sink * t
		hand_card_widgets[i].set_target_pos(Vector2(CARD_X_COORD_TABLE[hand_group_size][i], target_y) - hand_card_widgets[i].pivot_offset)

	glow_check()

func glow_check() -> void:
	for card_widget: CardWidget in hand_card_widgets:
		if card_widget.card.can_use(player, null):
			card_widget.begin_glow()
		else:
			card_widget.stop_glow()

func stop_glowing():
	for card_widget: CardWidget in hand_card_widgets:
		card_widget.stop_glow()


func build_pos_table() -> void:
	var middle_pos_x: float = Settings.DEFAULT_WIDTH / 2.0
	for i in range(1, 11):
		CARD_X_COORD_TABLE.set(i, {})
		CARD_Y_OFFSET_TABLE.set(i, {})
	
	# 1 card in hand
	CARD_X_COORD_TABLE[1][0] = middle_pos_x

	# 2 card in hand
	CARD_X_COORD_TABLE[2][0] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 0.47
	CARD_X_COORD_TABLE[2][1] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 0.53

	# 3 card in hand
	CARD_X_COORD_TABLE[3][0] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 0.9
	CARD_X_COORD_TABLE[3][1] = middle_pos_x
	CARD_X_COORD_TABLE[3][2] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 0.9

	# 4 card in hand
	CARD_X_COORD_TABLE[4][0] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 1.36
	CARD_X_COORD_TABLE[4][1] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 0.46
	CARD_X_COORD_TABLE[4][2] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 0.46
	CARD_X_COORD_TABLE[4][3] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 1.36

	# 5 card in hand
	CARD_X_COORD_TABLE[5][0] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 1.7
	CARD_X_COORD_TABLE[5][1] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 0.9
	CARD_X_COORD_TABLE[5][2] = middle_pos_x
	CARD_X_COORD_TABLE[5][3] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 0.9
	CARD_X_COORD_TABLE[5][4] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 1.7

	# 6 card in hand
	CARD_X_COORD_TABLE[6][0] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 2.1
	CARD_X_COORD_TABLE[6][1] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 1.3
	CARD_X_COORD_TABLE[6][2] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 0.43
	CARD_X_COORD_TABLE[6][3] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 0.43
	CARD_X_COORD_TABLE[6][4] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 1.3
	CARD_X_COORD_TABLE[6][5] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 2.1

	# 7 card in hand
	CARD_X_COORD_TABLE[7][0] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 2.4
	CARD_X_COORD_TABLE[7][1] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 1.7
	CARD_X_COORD_TABLE[7][2] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 0.9
	CARD_X_COORD_TABLE[7][3] = middle_pos_x
	CARD_X_COORD_TABLE[7][4] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 0.9
	CARD_X_COORD_TABLE[7][5] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 1.7
	CARD_X_COORD_TABLE[7][6] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 2.4

	# 8 card in hand
	CARD_X_COORD_TABLE[8][0] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 2.5
	CARD_X_COORD_TABLE[8][1] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 1.82
	CARD_X_COORD_TABLE[8][2] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 1.1
	CARD_X_COORD_TABLE[8][3] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 0.38
	CARD_X_COORD_TABLE[8][4] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 0.38
	CARD_X_COORD_TABLE[8][5] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 1.1
	CARD_X_COORD_TABLE[8][6] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 1.82
	CARD_X_COORD_TABLE[8][7] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 2.5

	# 9 card in hand
	CARD_X_COORD_TABLE[9][0] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 2.8
	CARD_X_COORD_TABLE[9][1] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 2.2
	CARD_X_COORD_TABLE[9][2] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 1.53
	CARD_X_COORD_TABLE[9][3] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 0.8
	CARD_X_COORD_TABLE[9][4] = middle_pos_x
	CARD_X_COORD_TABLE[9][5] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 0.8
	CARD_X_COORD_TABLE[9][6] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 1.53
	CARD_X_COORD_TABLE[9][7] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 2.2
	CARD_X_COORD_TABLE[9][8] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 2.8
	
	# 10 card in hand
	CARD_X_COORD_TABLE[10][0] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 2.9
	CARD_X_COORD_TABLE[10][1] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 2.4
	CARD_X_COORD_TABLE[10][2] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 1.8
	CARD_X_COORD_TABLE[10][3] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 1.1
	CARD_X_COORD_TABLE[10][4] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 0.4
	CARD_X_COORD_TABLE[10][5] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 0.4
	CARD_X_COORD_TABLE[10][6] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 1.1
	CARD_X_COORD_TABLE[10][7] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 1.8
	CARD_X_COORD_TABLE[10][8] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 2.4
	CARD_X_COORD_TABLE[10][9] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 2.9

func build_arrow() -> void:
	var sprite: Sprite2D
	if arrow_container == null:
		arrow_container = Control.new()
		arrow_container.name = "ArrowContainer"
		add_child(arrow_container)
	for i in range(arrow_points.size()-1):
		sprite = Sprite2D.new()
		sprite.name = "Circle" + str(i)
		sprite.texture = ImageMaster.combat_target_circle
		arrow_container.add_child(sprite)
		arrows.push_back(sprite)
	sprite = Sprite2D.new()
	sprite.name = "Arrow"
	sprite.texture = ImageMaster.combat_target_arrow
	arrow_container.add_child(sprite)
	arrows.push_back(sprite)
	arrow_container.visible = false
	arrow_container.z_index = Global.CARD_Z_INDEX + 2

func render_targeting_ui(delta: float) -> void:
	# arrow_container.visible = is_hovering_drop_zone
	# if not is_hovering_drop_zone:
	# 	return
	
	# draw arrow
	var start_arrow_pos: Vector2 = dragging_card.get_center_position()
	target_arrow_pos = MathHelper.vec2_lerp_snap(target_arrow_pos, get_global_mouse_position() / Settings.scale, delta * 20.0)
	# print("target_arrow_pos: " + str(target_arrow_pos) + " get_global_mouse_position():", get_global_mouse_position(), " scale:", Settings.scale)
	# print("get_global_mouse_position() / Settings.scale:", get_global_mouse_position() / Settings.scale)
	
	draw_curved_line(start_arrow_pos, target_arrow_pos)


func draw_curved_line(start_arrow_pos: Vector2, end_arrow_pos: Vector2) -> void:
	var control_point: Vector2 = Vector2.ZERO
	control_point.x = start_arrow_pos.x - (end_arrow_pos.x - start_arrow_pos.x) / 4.0
	control_point.y = end_arrow_pos.y + (end_arrow_pos.y - start_arrow_pos.y) / 2.0

	var radius: float = 7.0 * Settings.scale
	var count: int = arrow_points.size() - 1
	for i in range(count):
		arrow_points[i] = Beizer.quadratic(start_arrow_pos, control_point, end_arrow_pos, i / float(count))
		radius += 0.4 * Settings.scale
		arrows[i].position = arrow_points[i]
		arrows[i].scale = Vector2(radius / 18.0, radius / 18.0)
		var dir: Vector2 = arrow_points[i] - arrow_points[i-1] if i != 0 else control_point - arrow_points[i]
		arrows[i].rotation = dir.angle() + PI / 2.0

	var arrow_dir: Vector2 = target_arrow_pos - control_point
	var arrow: Sprite2D = arrows[arrow_points.size() - 1]
	arrow.position = target_arrow_pos
	arrow.scale = Vector2.ONE * Settings.scale
	arrow.rotation = arrow_dir.angle() + PI / 2.0
