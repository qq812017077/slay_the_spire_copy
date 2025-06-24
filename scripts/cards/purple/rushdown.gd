class_name Rushdown
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Adaptation"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Adaptation", card_string.name, "purple/power/rushdown", 1, card_string.description, CardType.POWER, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_magic_number = 2
	self.magic_number = self.base_magic_number