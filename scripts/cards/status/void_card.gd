class_name VoidCard
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Void"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Void", card_string.name, "status/void", -2, card_string.description, CardType.STATUS, CardColor.COLORLESS, CardRarity.COMMON, CardTarget.NONE)

	self.is_ethereal = true