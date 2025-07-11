class_name BootSequence
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "BootSequence"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("BootSequence", card_string.name, "blue/skill/boot_sequence", 0, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.is_innate = true
	self.exhaust = true
	self.base_block = 10

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_block(3)