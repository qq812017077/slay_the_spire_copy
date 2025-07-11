class_name EmptyMind
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "EmptyMind"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("EmptyMind", card_string.name, "purple/skill/empty_mind", 1, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_magic_number = 2
	self.magic_number = self.base_magic_number
	self.tags.append(CardTag.EMPTY)


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)
		self.rawDescription = card_string.upgrade_description
		initialize_description()