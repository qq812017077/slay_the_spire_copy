class_name DefendBlue
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Defend_B"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Defend_B", card_string.name, "blue/skill/defend", 1, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.BASIC, CardTarget.SELF)

	self.base_block = 5

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_block(3)