class_name Stack
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Stack"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Stack", card_string.name, "blue/skill/stack", 1, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.COMMON, CardTarget.SELF)

	self.base_block = 0

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_block(3)
		rawDescription = card_string.upgrade_description
		initialize_description()