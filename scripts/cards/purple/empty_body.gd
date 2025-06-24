class_name EmptyBody
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "EmptyBody"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("EmptyBody", card_string.name, "purple/skill/empty_body", 1, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.COMMON, CardTarget.SELF)

	self.base_block = 7
	self.tags.append(CardTag.EMPTY)