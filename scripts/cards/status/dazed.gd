class_name Dazed
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Dazed"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Dazed", card_string.name, "status/dazed", -2, card_string.description, CardType.STATUS, CardColor.COLORLESS, CardRarity.COMMON, CardTarget.NONE)

	self.is_ethereal = true
	