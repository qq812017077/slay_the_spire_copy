class_name Chill
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Chill"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Chill", card_string.name, "blue/skill/chill", 0, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.exhaust = true
	self.show_evoke_value = true
	self.show_evoke_orb_count = 3
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		is_innate = true
		rawDescription = card_string.upgrade_description
		initialize_description()