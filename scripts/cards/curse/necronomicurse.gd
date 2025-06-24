class_name Necronomicurse
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Necronomicurse"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Necronomicurse", card_string.name, "curse/necronomicurse", -2, card_string.description, CardType.CURSE, CardColor.CURSE, CardRarity.SPECIAL, CardTarget.NONE)
