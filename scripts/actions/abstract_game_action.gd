class_name AbstractGameAction
extends Node

enum ActionType {
	BLOCK, POWER, CARD_MANIPULATION, DAMAGE, DEBUFF, DISCARD, DRAW, EXHAUST, HEAL, ENERGY, TEXT, USE, CLEAR_CARD_QUEUE, DIALOG, SPECIAL, WAIT, SHUFFLE, REDUCE_POWER
}

enum AttackEffect{
	BLUNT_LIGHT, BLUNT_HEAVY, SLASH_DIAGONAL, SMASH, SLASH_HEAVY, SLASH_HORIZONTAL, SLASH_VERTICAL, NONE, FIRE, POISON, SHIELD, LIGHTNING
}

const DEFAULT_DURATION : float = 0.5

var duration: float
var start_duration: float 
var action_type: ActionType
var damage_type: DamageInfo.DamageType
var attack_effect: AttackEffect
var is_done: bool = false
var amount: int = 0

var target: AbstractCreature
var source: AbstractCreature

func set_values(t: AbstractCreature, s: AbstractCreature)-> void:
	target = t
	source = s
	duration = 0.5
	amount = 0

func set_values_with_damage_info(t: AbstractCreature, info: DamageInfo)-> void:
	target = t
	source = info.owner
	amount = info.output
	duration = 0.5

func set_values_with_amount(t: AbstractCreature, info: DamageInfo, vamount: int)-> void:
	target = t
	source = info.owner
	amount = vamount
	duration = 0.5

func is_dead_or_escaped()-> bool:
	return false

func tick(delta: float) -> void:
	duration -= delta
	if duration <= 0:
		is_done = true


func should_cancel() -> bool:
	return target == null or (source != null and source.is_dying) or target.is_dead_or_escaped()


static func add_to_bot(action: AbstractGameAction) -> void:
	CardGame.dungeon_main_screen.action_manager.add_to_bottom(action)
	
static func add_to_top(action: AbstractGameAction) -> void:
	CardGame.dungeon_main_screen.action_manager.add_to_top(action)