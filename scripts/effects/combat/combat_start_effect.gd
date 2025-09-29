class_name CombatStartEffect
extends AbstractGameEffect

static var ui_string : UIString = null
static var TEXT: Array
static var BATTLE_START_MSG: String
static var PLAYER_TURN_MSG: String
static var ENEMY_TURN_MSG: String
static var TURN_TXT: String

var suprise_attack: bool = false

var bg_color: Color
var sword_y: float = 0.0
var turn_msg: String = ""
var battle_start_msg: String = ""

var boss_fight: bool = false
# var show_hb: bool = false
var current_height : float = 0.0
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
    #     CardGame.dungeon_main_screen.dungeon_room_screen.show_health_bar()
    #     show_hb = true
    
    if duration > 3.0:
        current_height = MathHelper.lerp_snap(current_height, 150.0, delta * 3.0)
    elif duration < 0.5:
        current_height = MathHelper.lerp_snap(current_height, 0.0, delta * 3.0)

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