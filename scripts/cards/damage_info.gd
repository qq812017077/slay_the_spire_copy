class_name DamageInfo
extends Object

enum DamageType {NORMAL, THORNS, HP_LOSS}

var owner: AbstractCreature
var name: String
var damage_type: DamageType
var base: int = 0
var output: int = 0
var is_modified: bool = false

func _init(source: AbstractCreature, _base: int, _damage_type: DamageType = DamageType.NORMAL) -> void:
    owner = source
    name = source.name
    self.base = _base
    self.damage_type = _damage_type