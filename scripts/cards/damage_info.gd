class_name DamageInfo
extends Object

enum DamageType {NORMAL, THORNS, HP_LOSS}

var owner: AbstractCreature
var name: String
var damage_type: DamageType
var base: int = 0
var output: int = 0
var is_modified: bool = false