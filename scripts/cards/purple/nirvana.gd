class_name Nirvana
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Nirvana"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Nirvana", card_string.name, "purple/power/nirvana", 1, card_string.description, CardType.POWER, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_magic_number = 3
	self.magic_number = self.base_magic_number