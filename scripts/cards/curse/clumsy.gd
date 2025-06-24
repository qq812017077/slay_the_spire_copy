class_name Clumsy
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Clumsy"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Clumsy", card_string.name, "curse/clumsy", -2, card_string.description, CardType.CURSE, CardColor.CURSE, CardRarity.CURSE, CardTarget.NONE)

	self.is_ethereal = true