class_name Soul
extends Control

const FAST_BACK_UP_TIME: float = 0.5
const BACK_UP_TIME: float = 1.5

const MASTER_DECK_POS: Vector2 = Vector2(1750, 50)
const HOME_IN_THRESHOLD: float = 72
const DST_THRESHOLD: float = 36

const VELOCITY_RAMP_RATE: float = 1000.0
const MAX_VELOCITY: float = 6000.0
const ROTATION_RATE: float = 150.0
const START_VELOCITY: float = 200.0

const EFFECT_INTERVAL: float = 0.015

static var card_trail_effect_pool: Array[CardTrailEffect] = []

var card_widget: CardWidget = null
var is_working: bool = false
var is_done: bool = false
var group: CardGroup = null

var crs: CatmullRomSpline = CatmullRomSpline.new()
var control_points: Array[Vector2] = []
var target_pos: Vector2
var target_scale: Vector2 = Vector2.ONE
# shared variables
var rotate_rate: float
var cur_speed: float
var backup_timer: float

var stop_rotating: bool = false
var rotate_clockwise: bool = true
var rotate_angle: float = 0.0
var wait_timer: float = 0.0

var effect_timer: float = 0.0
func _ready() -> void:
	name = "Soul"

func obtain(vcard: CardWidget) -> void:
	card_widget = vcard
	group = CardGame.dungeon_main_screen.player.master_decks
	var orig_transform: Transform2D = card_widget.get_global_transform()
	
	if card_widget.get_parent() != null:
		card_widget.get_parent().remove_child(card_widget)
	add_child(card_widget)

	card_widget.global_position = orig_transform.get_origin()
	card_widget.scale = orig_transform.get_scale() / card_widget.get_global_transform().get_scale()
	card_widget.z_index = Global.SOUL_Z_INDEX
	target_pos = CardGame.dungeon_main_screen.top_panel.deck.global_position + CardGame.dungeon_main_screen.top_panel.deck.texture.get_size() / 2.0
	target_scale = Vector2(0.13, 0.13)

	effect_timer = 0.015
	set_shared_variables()

func active() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT

func deactive() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func set_shared_variables() -> void:
	control_points.clear()
	if Settings.FAST_MODE:
		rotate_rate = ROTATION_RATE * randf_range(4.0, 6.0)
		cur_speed = START_VELOCITY * randf_range(1.0, 1.5)
		backup_timer = FAST_BACK_UP_TIME
	else:
		rotate_rate = ROTATION_RATE * randf_range(1.0, 2.0)
		cur_speed = START_VELOCITY * randf_range(0.2, 1.0)
		backup_timer = BACK_UP_TIME

	wait_timer = 0.02
	stop_rotating = false
	rotate_clockwise = randi_range(0, 1) == 0
	rotate_angle = randf_range(0, 359)
	is_working = true
	is_done = false

func _process(delta: float) -> void:
	if not is_working:
		return
	if is_carrying_card():
		if wait_timer > 0.0:
			wait_timer -= delta
			return
		update_movement(delta)
		update_card_scale(delta)
		update_backup_timer(delta)
	else:
		is_done = true

	if is_done:
		is_working = false
		
		match group.card_group_type:
			CardGroup.CardGroupType.MASTER_DECK:
				group.add_to_top(card_widget.card)
				CardGame.dungeon_main_screen.top_panel.refresh_master_deck_amount()
				CardWidget.recycle(card_widget)
			CardGroup.CardGroupType.DRAW_PILE:
				pass
			CardGroup.CardGroupType.DISCARD_PILE:
				pass

func update_movement(delta: float) -> void:
	var cur_pos: Vector2 = card_widget.get_center_position()
	var target_dir: Vector2 = target_pos - cur_pos
	var target_angle: float = rad_to_deg(target_dir.normalized().angle())
	if target_angle < -90.0:
		target_angle += 360.0
	elif target_angle >= 270.0:
		target_angle -= 360.0
	if target_pos.distance_to(cur_pos) < HOME_IN_THRESHOLD:
		stop_rotating = true
		is_done = true
		return

	if not stop_rotating:
		rotate_rate += delta * 800.0
		var rotate_delta: float = rotate_rate * delta
		if rotate_clockwise:
			rotate_angle += rotate_delta
		else:
			rotate_angle -= rotate_delta
		var ang_diff: float = absf(rotate_angle - target_angle)
		if fmod(ang_diff, 360.0) < rotate_delta:
			stop_rotating = true
	else:
		var ang_diff: float = absf(rotate_angle - target_angle)
		if ang_diff < rotate_rate * delta:
			rotate_angle = target_angle
		else:
			ang_diff = fmod(ang_diff, 360.0)
			if rotate_clockwise:
				if rotate_angle < target_angle:
					rotate_angle = target_angle
				else:
					rotate_angle = target_angle + 360.0
			else:
				if rotate_angle > target_angle:
					rotate_angle = target_angle
				else:
					rotate_angle = target_angle - 360.0
	
	# print("card_widget.rotation_degrees {2}, rotate_angle: {0}, target_angle: {1}".format([rotate_angle + 90, target_angle + 90, card_widget.rotation_degrees]))
	
	var move_dir: Vector2 = Vector2.from_angle(deg_to_rad(card_widget.rotation_degrees - 90))
	# move_dir.y *= -1.0
	move_dir *= cur_speed * delta
	cur_pos += move_dir
	if stop_rotating and backup_timer < 1.3499999:
		cur_speed += delta * VELOCITY_RAMP_RATE * 3.0
	else:
		cur_speed += delta * VELOCITY_RAMP_RATE * 1.5
	
	cur_speed = clamp(cur_speed, 0.0, MAX_VELOCITY)

	if target_pos.x < (Settings.WIDTH / 2.0) and cur_pos.x < 0.0:
		is_done = true
	elif target_pos.x > (Settings.WIDTH / 2.0) and cur_pos.x > Settings.WIDTH:
		is_done = true
	
	if target_pos.distance_to(cur_pos) < DST_THRESHOLD:
		is_done = true
	
	card_widget.position = cur_pos - card_widget.size / 2.0
	card_widget.rotation_degrees = MathHelper.lerp_snap(card_widget.rotation_degrees, rotate_angle + 90, delta * 12.0)

	effect_timer -= delta
	if effect_timer < 0.0:
		effect_timer = EFFECT_INTERVAL

		if not control_points.is_empty():
			if control_points[0].distance_to(cur_pos) > 1.0:
				control_points.append(cur_pos)
		else:
			control_points.append(cur_pos)
		
		if control_points.size() > 10:
			control_points.pop_front()
		
		if control_points.size() > 3:
			crs.load_points(control_points)

			for i in range(0, 20):
				var effect_pos: Vector2 = crs.value_at(i / 19.0)
				var effect: CardTrailEffect = get_trail_effect()
				effect.reset(effect_pos)
				CardGame.dungeon_main_screen.add_game_effect(effect)


func update_card_scale(delta: float) -> void:
	if is_working:
		card_widget.scale = MathHelper.vec2_lerp_snap(card_widget.scale, target_scale, delta * 12.0)

func update_backup_timer(delta: float) -> void:
	backup_timer -= delta
	if backup_timer < 0.0:
		is_done = true

func is_carrying_card() -> bool:
	if group == null:
		return true
	
	match group.card_group_type:
		CardGroup.CardGroupType.DRAW_PILE:
			return false
		CardGroup.CardGroupType.DISCARD_PILE:
			return false
	
	return true
static func is_idle_soul(soul: Soul) -> bool:
	return soul.is_done


static func get_trail_effect() -> CardTrailEffect:
	if card_trail_effect_pool.size() > 0:
		return card_trail_effect_pool.pop_back()
	return CardGame.effect_library.card_trail_effect_prefab.instantiate()

static func recycle_trail_effect(effect: CardTrailEffect) -> void:
	if effect.get_parent() != null:
		effect.get_parent().remove_child(effect)
	
	card_trail_effect_pool.append(effect)
