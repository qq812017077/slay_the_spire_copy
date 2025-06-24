class_name DevaForm
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "DevaForm"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("DevaForm", card_string.name, "purple/power/deva_form", 3, card_string.description, CardType.POWER, CardColor.PURPLE, CardRarity.RARE, CardTarget.SELF)

	self.is_ethereal = true
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number