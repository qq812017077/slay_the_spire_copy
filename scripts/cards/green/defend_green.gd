class_name DefendGreen
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Defend_G"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Defend_G", card_string.name, "green/skill/defend", 1, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.BASIC, CardTarget.SELF)

	self.base_block = 5
	self.tags.append(CardTag.STARTER_DEFEND)