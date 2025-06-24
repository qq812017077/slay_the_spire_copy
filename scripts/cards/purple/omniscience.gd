class_name Omniscience
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Omniscience"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Omniscience", card_string.name, "purple/skill/omniscience", 4, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.RARE, CardTarget.NONE)

	self.exhaust = true
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number