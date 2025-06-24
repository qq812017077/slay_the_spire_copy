class_name Flex
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Flex"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Flex", card_string.name, "red/skill/flex", 0, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.COMMON, CardTarget.SELF)

	self.base_magic_number = 2
	self.magic_number = self.base_magic_number