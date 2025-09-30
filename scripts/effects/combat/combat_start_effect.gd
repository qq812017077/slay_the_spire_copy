class_name CombatStartEffect
extends AbstractGameEffect

static var ui_string : UIString = null
static var TEXT: Array
static var BATTLE_START_MSG: String
static var PLAYER_TURN_MSG: String
static var ENEMY_TURN_MSG: String
static var TURN_TXT: String

static var MSG_VANISH_X: float = - Settings.DEFAULT_WIDTH * 0.25
static var WIDTH_DIV_2: float = Settings.DEFAULT_WIDTH / 2.0
static var HEIGHT_DIV_2: float = Settings.DEFAULT_HEIGHT / 2.0

static var SWORD_START_X: float = -50.0
static var SWORD_DEST_X: float = WIDTH_DIV_2
var suprise_attack: bool = false

@export var bg_tex: TextureRect
@export var sword_1: Sprite2D
@export var sword_2: Sprite2D

var bg_color: Color
var turn_msg: String = ""
var battle_start_msg: String = ""

var turn_msg_color: Color = Color(0.7, 0.7, 0.7, 0)

var boss_fight: bool = false
# var show_hb: bool = false
var current_height : float = 0.0

var timer1: float = 0.0
var timer2: float = 0.0
var first_msg_x : float = 0
var second_msg_x : float = 0

var play_sound: bool = false

var sword_timer: float = 0.5
var sword_color: Color = Color(0.9, 0.9, 0.85, 0)
var sword_pos: Vector2 = Vector2.ZERO
var sword_angle: float = 0.0
var play_sword_sound: bool = false

func _ready() -> void:
	if ui_string == null:
		ui_string = CardGame.languagePack.get_ui_string("BattleStartEffect")
		TEXT = ui_string.TEXT
		BATTLE_START_MSG = TEXT[0]
		PLAYER_TURN_MSG = TEXT[1]
		ENEMY_TURN_MSG = TEXT[2]
		TURN_TXT = TEXT[3]
	
	duration = 4.0
	starting_duration = duration

	first_msg_x = Settings.DEFAULT_WIDTH / 2.0
	second_msg_x = Settings.DEFAULT_WIDTH * 1.5

	bg_color = CardGame.dungeon_main_screen.dungeon.fade_color / 2.0
	bg_color.a = 0

	color = ThemeHelper.GOLD_COLOR
	color.a = 0.0

	if Settings.usesOrdinal:
		battle_start_msg = str(CardGame.action_manager.turn) + get_ordinal_naming(CardGame.action_manager.turn) + TURN_TXT
	else:
		battle_start_msg = str(CardGame.action_manager.turn) + TURN_TXT

	boss_fight = CardGame.dungeon_main_screen.dungeon_room_screen.is_boss_room()

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
	
	if duration > 3.0:
		current_height = MathHelper.lerp_snap(current_height, 150.0, delta * 3.0)
	elif duration < 0.5:
		current_height = MathHelper.lerp_snap(current_height, 0.0, delta * 3.0)

	if duration < 3.0 and timer1 > 0.0:
		timer1 = max(timer1 - delta, 0.0)

		first_msg_x = CardGame.interpolation._apply_powin(first_msg_x, MSG_VANISH_X, 1.0 - timer1, 2)
	elif duration < 3.0 and timer2 > 0.0:
		timer2 = max(timer2 - delta, 0.0)
		if not play_sound:
			CardGame.sound.single_play("TURN_EFFECT")
			play_sound = true
			CardGame.dungeon_main_screen.dungeon_room_screen.show_monster_intent()
		second_msg_x = CardGame.interpolation._apply_powin(first_msg_x, WIDTH_DIV_2, 1.0 - timer2, 2)
	
	var target_alpha : float = 1.0 if duration > 1.0 else 0.0
	color.a = MathHelper.lerp_snap(color.a , target_alpha * 0.75, delta * 5.0)

	turn_msg_color.a = color.a

	if Settings.FAST_MODE:
		duration -= delta
	duration -= delta

	if duration < 0.0:
		is_done = true

	update_swords(delta)
	update_tex()

func update_tex():
	bg_tex.position = Vector2(0, HEIGHT_DIV_2 - current_height / 2.0)
	bg_tex.size = Vector2(Settings.DEFAULT_WIDTH, HEIGHT_DIV_2)
	bg_tex.modulate = bg_color



func update_swords(delta: float) -> void:
	sword_timer = max(sword_timer-delta, 0.0)

	sword_color.a = CardGame.interpolation.apply_fade(1.0,0.01, sword_timer / 0.5)

	if boss_fight:
		if sword_timer < 0.1 and not play_sword_sound:
			play_sword_sound = true

		CardGame.screen_shake.shake(ScreenShake.ShakeIntensity.MED, ScreenShake.ShakeDur.SHORT, false)
		var effect = UpgradeShineEffect.new(Vector2(Settings.DEFAULT_WIDTH / 2.0, Settings.DEFAULT_HEIGHT / 2.0))
		CardGame.dungeon_main_screen.add_game_effect(effect)
		sword_pos.x = CardGame.interpolation._apply_powout(SWORD_DEST_X, SWORD_START_X, sword_timer / 0.5)
		sword_angle = CardGame.interpolation._apply_powout(-50.0, 500.0, sword_timer / 0.5)
	else:
		sword_pos.x = SWORD_DEST_X
		sword_angle = -50.0

func create_player_turn_effect() -> CombatStartEffect:
	var effect = CombatStartEffect.new()
	effect.turn_msg = PLAYER_TURN_MSG
	return effect
	

func create_enemy_turn_effect() -> CombatStartEffect:
	var effect = CombatStartEffect.new()
	effect.turn_msg = ENEMY_TURN_MSG
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