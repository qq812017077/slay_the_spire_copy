class_name Regret
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Regret"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Regret", card_string.name, "curse/regret", -2, card_string.description, CardType.CURSE, CardColor.CURSE, CardRarity.CURSE, CardTarget.NONE)
