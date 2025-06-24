class_name Decay
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Decay"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Decay", card_string.name, "curse/decay", -2, card_string.description, CardType.CURSE, CardColor.CURSE, CardRarity.CURSE, CardTarget.NONE)
