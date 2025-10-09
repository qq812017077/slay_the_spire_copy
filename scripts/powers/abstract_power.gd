class_name AbstractPower
extends Object

var id: String = ""

func can_play_card(card: AbstractCard) -> bool:
	return true

func at_start_of_turn() -> void:
	pass

func at_end_of_turn(_player: AbstractPlayer):
	pass

func at_end_of_turn_pre_end_turn_cards(_player: AbstractPlayer):
	pass

func at_end_of_round(_player: AbstractPlayer):
	pass