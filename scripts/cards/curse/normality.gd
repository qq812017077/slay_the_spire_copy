class_name Normality
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Normality"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Normality", card_string.name, "curse/normality", -2, card_string.description, CardType.CURSE, CardColor.CURSE, CardRarity.CURSE, CardTarget.NONE)
