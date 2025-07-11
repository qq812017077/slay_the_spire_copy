class_name MentalFortress
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "MentalFortress"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("MentalFortress", card_string.name, "purple/power/mental_fortress", 1, card_string.description, CardType.POWER, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_magic_number = 4
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(2)