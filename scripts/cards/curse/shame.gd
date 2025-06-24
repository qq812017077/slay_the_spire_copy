class_name Shame
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Shame"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Shame", card_string.name, "curse/shame", -2, card_string.description, CardType.CURSE, CardColor.CURSE, CardRarity.CURSE, CardTarget.NONE)
