class_name ReinforcedBody
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Reinforced Body"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Reinforced Body", card_string.name, "blue/skill/reinforced_body", -1, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_block = 7