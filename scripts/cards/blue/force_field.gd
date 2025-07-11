class_name ForceField
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Force Field"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Force Field", card_string.name, "blue/skill/forcefield", 4, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_block = 12

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_block(4)