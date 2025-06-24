class_name Fasting
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Fasting2"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Fasting2", card_string.name, "purple/power/fasting", 2, card_string.description, CardType.POWER, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_magic_number = 3
	self.magic_number = self.base_magic_number