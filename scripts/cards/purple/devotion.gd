class_name Devotion
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Devotion"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Devotion", card_string.name, "purple/power/devotion", 1, card_string.description, CardType.POWER, CardColor.PURPLE, CardRarity.RARE, CardTarget.NONE)

	self.base_magic_number = 2
	self.magic_number = self.base_magic_number