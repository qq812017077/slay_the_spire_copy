class_name Stack
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Stack"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Stack", card_string.name, "blue/skill/stack", 1, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.COMMON, CardTarget.SELF)

	self.base_block = 0