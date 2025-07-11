class_name Glacier
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Glacier"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Glacier", card_string.name, "blue/skill/glacier", 2, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.show_evoke_value = true
	self.show_evoke_orb_count = 2
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number
	self.base_block = 7

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_block(3)
		rawDescription = card_string.upgrade_description
		initialize_description()