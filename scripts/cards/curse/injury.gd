class_name Injury
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Injury"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Injury", card_string.name, "curse/injury", -2, card_string.description, CardType.CURSE, CardColor.CURSE, CardRarity.CURSE, CardTarget.NONE)
