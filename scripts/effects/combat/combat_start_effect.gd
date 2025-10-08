class_name CombatStartEffect
extends AbstractGameEffect

const FIRST_TIME: float = 0.8
const SECOND_TIME: float = 0.8
static var ui_string : UIString = null
static var TEXT: Array
static var BATTLE_START_MSG: String
static var PLAYER_TURN_MSG: String
static var ENEMY_TURN_MSG: String
static var TURN_TXT: String

static var MSG_VANISH_X: float = - Settings.DEFAULT_WIDTH * 0.25
static var WIDTH_DIV_2: float = Settings.DEFAULT_WIDTH / 2.0
static var HEIGHT_DIV_2: float = Settings.DEFAULT_HEIGHT / 2.0
# 1.5 width
static var WIDTH_1P5: float = Settings.DEFAULT_WIDTH * 1.5

static var SWORD_START_X: float = -50.0
static var SWORD_DEST_X: float = WIDTH_DIV_2
static var SWORD_ANGLE: float = -50.0
static var MAIN_MSG_OFFSET_Y: float = -40.0
static var TURN_MSG_OFFSET_Y: float = 20.0

var suprise_attack: bool = false

@export var reset: bool = false
@export var bg_tex: TextureRect
@export var sword_1: Sprite2D
@export var sword_2: Sprite2D
@export var battle_start_info_msg: Label
@export var turn_type_msg: Label
@export var turn_num_msg: Label

var bg_color: Color
var turn_msg_color: Color = Color(0.7, 0.7, 0.7, 0)

var boss_fight: bool = false
# var show_hb: bool = false
var current_height : float = 0.0

var timer1: float = FIRST_TIME
var timer2: float = SECOND_TIME
var first_msg_x : float = WIDTH_DIV_2
var second_msg_x : float = WIDTH_1P5

var play_sound: bool = false

var sword_timer: float = 0.5
var sword_color: Color = Color(0.9, 0.9, 0.85, 0)
var sword_x: float = 0.0
var sword_angle: float = 0.0
var sword_img: Texture2D
var play_sword_sound: bool = false

func _ready() -> void:
	if ui_string == null:
		ui_string = CardGame.languagePack.get_ui_string("BattleStartEffect")
		TEXT = ui_string.TEXT
		BATTLE_START_MSG = TEXT[0]
		PLAYER_TURN_MSG = TEXT[1]
		ENEMY_TURN_MSG = TEXT[2]
		TURN_TXT = TEXT[3]
	
	bg_tex.texture = ImageMaster.white_square_img
	sword_1.texture = ImageMaster.combat_sword
	sword_2.texture = ImageMaster.combat_sword

	duration = 4.0
	starting_duration = duration
	first_msg_x = WIDTH_DIV_2
	second_msg_x = WIDTH_1P5
	sword_img = sword_1.texture
	bg_color = CardGame.dungeon_main_screen.dungeon.fade_color / 2.0 if CardGame.dungeon_main_screen != null else Color.hex(0x1e0f0aff) / 2.0
	bg_color.a = 0

	color = ThemeHelper.GOLD_COLOR
	color.a = 0.0

	ThemeHelper.apply_label_font_style_with_settings(battle_start_info_msg, ThemeHelper.banner_name_label_settings, Color.WHITE)
	ThemeHelper.apply_label_font_style_with_settings(turn_type_msg, ThemeHelper.banner_name_label_settings, Color.WHITE)
	ThemeHelper.apply_label_font_style_with_settings(turn_num_msg, ThemeHelper.turn_num_label_settings, Color.WHITE)

	battle_start_info_msg.text = BATTLE_START_MSG
	if turn_type_msg.text == "":
		turn_type_msg.text = PLAYER_TURN_MSG
	if Settings.usesOrdinal:
		turn_num_msg.text = str(CardGame.action_manager.turn) + get_ordinal_naming(CardGame.action_manager.turn) + TURN_TXT
	else:
		turn_num_msg.text = str(CardGame.action_manager.turn) + TURN_TXT
	
	boss_fight = CardGame.dungeon_main_screen.dungeon_room_screen.is_boss_room() if CardGame.dungeon_main_screen != null else false

	if boss_fight:
		CardGame.sound.single_play("BATTLE_START_BOSS")
	elif randf() < 0.5:
		CardGame.sound.single_play("BATTLE_START_1")
	else:
		CardGame.sound.single_play("BATTLE_START_2")

	# show_hb = false
func _process(delta: float) -> void:
	# if not show_hb:
	#	 CardGame.dungeon_main_screen.dungeon_room_screen.show_health_bar()
	#	 show_hb = true
	if Engine.is_editor_hint() and reset:
		do_reset_in_editor()

	if Settings.FAST_MODE:
		duration -= delta
	duration -= delta

	if duration > 4.0:
		return 
	
	if duration > 3.0:
		current_height = MathHelper.lerp_snap(current_height, 150.0, delta * 3.0)
	elif duration < 0.5:
		current_height = MathHelper.lerp_snap(current_height, 0.0, delta * 3.0)

	if duration < 3.0 and timer1 > 0.0:
		timer1 = max(timer1 - delta, 0.0)
		first_msg_x = CardGame.interpolation._apply_powin(WIDTH_DIV_2, MSG_VANISH_X, (FIRST_TIME - timer1) / FIRST_TIME, 4)
	elif duration < 3.0 and timer2 > 0.0:
		timer2 = max(timer2 - delta, 0.0)
		if not play_sound:
			CardGame.sound.single_play("TURN_EFFECT")
			play_sound = true
			if CardGame.dungeon_main_screen:
				CardGame.dungeon_main_screen.dungeon_room_screen.show_monster_intent()
		second_msg_x = CardGame.interpolation._apply_powin(WIDTH_1P5, WIDTH_DIV_2, (SECOND_TIME - timer2) / SECOND_TIME, 2)
	
	var target_alpha : float = 1.0 if duration > 1.0 else 0.0
	color.a = MathHelper.lerp_snap(color.a , target_alpha * 0.75, delta * 5.0)

	turn_msg_color.a = color.a
	bg_color.a = color.a 
	
	if duration < 0.0:
		is_done = true

	update_bg()
	update_swords(delta)
	update_msg()

func update_bg():
	bg_tex.position = Vector2(0, HEIGHT_DIV_2 - current_height / 2.0 - 20.0)
	bg_tex.size = Vector2(Settings.DEFAULT_WIDTH, current_height)
	bg_tex.modulate = bg_color

func update_msg():
	battle_start_info_msg.position = Vector2(first_msg_x, HEIGHT_DIV_2 + MAIN_MSG_OFFSET_Y) - battle_start_info_msg.size / 2.0

	turn_type_msg.position = Vector2(second_msg_x, HEIGHT_DIV_2 + MAIN_MSG_OFFSET_Y) - turn_type_msg.size / 2.0
	if not suprise_attack:
		turn_num_msg.position = Vector2(second_msg_x, HEIGHT_DIV_2 + TURN_MSG_OFFSET_Y) - turn_num_msg.size / 2.0
	
	battle_start_info_msg.modulate = color
	turn_type_msg.modulate = color
	turn_num_msg.modulate = turn_msg_color

func update_swords(delta: float) -> void:
	sword_timer = max(sword_timer - delta, 0.0)

	sword_color.a = CardGame.interpolation.apply_fade(1.0,0.01, sword_timer / 0.5)

	if boss_fight:
		if sword_timer < 0.1 and not play_sword_sound:
			play_sword_sound = true

		CardGame.screen_shake.shake(ScreenShake.ShakeIntensity.MED, ScreenShake.ShakeDur.SHORT, false)
		if CardGame.dungeon_main_screen:
			var effect = UpgradeShineEffect.new(Vector2(Settings.DEFAULT_WIDTH / 2.0, Settings.DEFAULT_HEIGHT / 2.0))
			CardGame.dungeon_main_screen.add_game_effect(effect)
		sword_x = CardGame.interpolation._apply_powout(SWORD_DEST_X, SWORD_START_X, sword_timer / 0.5)
		sword_angle = CardGame.interpolation._apply_powout(SWORD_ANGLE, 500.0, sword_timer / 0.5)
	else:
		sword_x = SWORD_DEST_X
		sword_angle = SWORD_ANGLE
	
	sword_1.position.x = Settings.DEFAULT_WIDTH - sword_x + first_msg_x - WIDTH_DIV_2
	sword_2.position.x = sword_x + first_msg_x - WIDTH_DIV_2
	sword_1.position.y = HEIGHT_DIV_2 + MAIN_MSG_OFFSET_Y
	sword_2.position.y = HEIGHT_DIV_2 + MAIN_MSG_OFFSET_Y
	
	sword_1.modulate = sword_color
	sword_2.modulate = sword_color

	sword_1.rotation_degrees = -sword_angle
	sword_2.rotation_degrees = sword_angle

func do_reset_in_editor() -> void:
	reset = false
	is_done = false
	duration = 4.0
	starting_duration = duration

	first_msg_x = WIDTH_DIV_2
	second_msg_x = WIDTH_1P5
	sword_img = sword_1.texture
	bg_color = CardGame.dungeon_main_screen.dungeon.fade_color / 2.0 if CardGame.dungeon_main_screen != null else Color.hex(0x1e0f0aff) / 2.0
	bg_color.a = 0

	color = ThemeHelper.GOLD_COLOR
	color.a = 0.0
	timer1 = FIRST_TIME
	timer2 = SECOND_TIME
	sword_timer = 0.5
static func create_player_turn_effect() -> CombatStartEffect:
	var effect = CardGame.effect_library.combat_start_effect_prefab.instantiate()
	effect.turn_type_msg.text = PLAYER_TURN_MSG
	# print("effect.turn_type_msg.text:", effect.turn_type_msg.text)
	return effect
	

static func create_enemy_turn_effect() -> CombatStartEffect:
	var effect = CardGame.effect_library.combat_start_effect_prefab.instantiate()
	effect.turn_type_msg.text = ENEMY_TURN_MSG
	# print("effect.turn_type_msg.text:", effect.turn_type_msg.text)
	return effect


static func get_ordinal_naming(num: int) -> String:
	if num % 100 == 11 or num % 100 == 12 or num % 100 == 13:
		return "th"
	elif num % 10 == 1:
		return "st"
	elif num % 10 == 2:
		return "nd"
	elif num % 10 == 3:
		return "rd"
	else:
		return "th"
