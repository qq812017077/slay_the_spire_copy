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

var damage_list: Array[DamageInfo] = []
var move_name: String = ""
var move_history: Array[int] = []
var move: EnemyMoveInfo = null

var anims: Array[String] = []
func _init(_name: String, _id: String, _maxHealth: int, _imgUrl: String, _ignoreBlights: bool=false):
    name = _name
    id = _id

    

func build() -> void:
    roll_move()

func roll_move() -> void:
    get_move(CardGame.dungeon_main_screen.dungeon.aiRng.randi_range(0, 99))

func get_move(_num: int)-> void:
    pass

func set_move_default(next_move: int, intent: Intent, base_damage: int) -> void:
    if intent == Intent.ATTACK or intent == Intent.ATTACK_BUFF or intent == Intent.ATTACK_DEBUFF or intent == Intent.ATTACK_DEFEND:
        # for i in range(8):
        #     CardGame.dungeon_main_screen.add_game_effect(
        pass
    set_move(move_name, next_move, intent, -1, 0, false)

func set_move(_move_name: String, next_move: int, intent: Intent, base_damage: int = -1, multipler: float = 0.0, is_multi_damage: bool = false) -> void:
    move_name = _move_name
    if next_move != -1:
        move_history.append(next_move)
    move = EnemyMoveInfo.new(next_move, intent, base_damage, multipler, is_multi_damage)


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