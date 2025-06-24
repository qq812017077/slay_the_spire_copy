class_name Parasite
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Parasite"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Parasite", card_string.name, "curse/parasite", -2, card_string.description, CardType.CURSE, CardColor.CURSE, CardRarity.CURSE, CardTarget.NONE)
