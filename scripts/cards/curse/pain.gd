class_name Pain
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Pain"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Pain", card_string.name, "curse/pain", -2, card_string.description, CardType.CURSE, CardColor.CURSE, CardRarity.CURSE, CardTarget.NONE)
