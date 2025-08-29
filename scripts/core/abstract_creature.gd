class_name AbstractCreature
extends Object

enum CreatureAnimation {
    FAST_SHAKE, SHAKE, ATTACK_FAST, ATTACK_SLOW, STAGGER, HOP, JUMP
}

static var ui_string: UIString 
static var TEXT: Array

var id: String
var name: String
var powers: Array[AbstractPower] = []

var is_player: bool = false

var gold: int = 0

# hp
var starting_max_health: int = 0
var max_health: int = 0
var current_health: int = 0

# block
var current_block: int = 0

var is_dying: bool = false
var is_dead: bool = false
var half_dead: bool = false
var is_half_dead: bool = false
var escape_timer: bool = false
var is_escaping: bool = false

# anim
var animation : SpriteFrames = null

func _init() -> void:
    if ui_string == null:
        ui_string = CardGame.languagePack.get_ui_string("AbstractCreature")
        TEXT = ui_string.TEXT

func damage(info: DamageInfo) -> void:
    pass

func has_power(power_id : String) -> bool:
    for power : AbstractPower in powers:
        if power.id == power_id:
            return true
    return false

func load_animation(anim: SpriteFrames) -> void:
    animation = anim
    pass