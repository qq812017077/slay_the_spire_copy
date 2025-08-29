class_name AbstractMonster
extends AbstractCreature

enum Intent { NONE, ATTACK, ATTACK_BUFF, ATTACK_DEBUFF, ATTACK_DEFEND, BUFF, DEBUFF, STRONG_DEBUFF, DEFEND, DEFEND_DEBUFF, DEFEND_BUFF, ESCAPE, MAGIC, SLEEP, STUN, UNKNOWN, DEBUG}

enum EnemyType { NORMAL, ELITE, BOSS }

static func initialize() -> void:
    pass

var type: EnemyType = EnemyType.NORMAL
var intent: Intent = Intent.NONE
var tip_intent: Intent = Intent.DEBUG
var escaped: bool = false

func _init(_name: String, _id: String, _maxHealth: int, _imgUrl: String, _ignoreBlights: bool=false):
    name = _name
    id = _id
    

func show_intent() -> void:
    pass


func escape() -> void:
    is_escaping = true
    escape_timer = 3.0

func die(trigger_relic: bool) -> void:
    pass

func is_dead_or_escaped() -> bool:
    # if is_dying 
    return false