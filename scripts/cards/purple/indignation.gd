class_name Indignation
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Indignation"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Indignation", card_string.name, "purple/skill/indignation", 1, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.NONE)

	self.base_magic_number = 3
	self.magic_number = self.base_magic_number