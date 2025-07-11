class_name DefendWatcher
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Defend_P"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Defend_P", card_string.name, "purple/skill/defend", 1, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.BASIC, CardTarget.SELF)

	self.base_block = 5
	self.tags.append(CardTag.STARTER_DEFEND)


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_block(3)