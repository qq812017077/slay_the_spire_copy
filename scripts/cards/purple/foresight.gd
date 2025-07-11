class_name Foresight
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Wireheading"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Wireheading", card_string.name, "purple/power/foresight", 1, card_string.description, CardType.POWER, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.NONE)

	self.base_magic_number = 3
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)