class_name InnerPeace
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "InnerPeace"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("InnerPeace", card_string.name, "purple/skill/inner_peace", 1, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_magic_number = 3
	self.magic_number = self.base_magic_number