class_name EnemyMoveInfo
extends Object

var next_move: int = -1
var intent: AbstractMonster.Intent = AbstractMonster.Intent.NONE
var base_damage: int = 0
var multipler: float = 0.0
var is_multi_damage: bool = false

func _init(_next_move: int, _intent: AbstractMonster.Intent, _base_damage: int, _multipler: float, _is_multi_damage: bool) -> void:
    self.next_move = _next_move
    self.intent = _intent
    self.base_damage = _base_damage
    self.multipler = _multipler
