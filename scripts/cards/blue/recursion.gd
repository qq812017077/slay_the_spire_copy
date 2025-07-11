class_name Recursion
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Redo"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Redo", card_string.name, "blue/skill/recursion", 1, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.COMMON, CardTarget.SELF)
	

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_base_cost(0)