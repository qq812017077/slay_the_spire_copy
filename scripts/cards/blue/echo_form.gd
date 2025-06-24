class_name EchoForm
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Echo Form"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Echo Form", card_string.name, "blue/power/echo_form", 3, card_string.description, CardType.POWER, CardColor.BLUE, CardRarity.RARE, CardTarget.SELF)

	self.is_ethereal = true