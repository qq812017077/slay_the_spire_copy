class_name Perseverance
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Perseverance"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Perseverance", card_string.name, "purple/skill/perseverance", 1, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_block = 5
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number
	self.self_retain = true



func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_block(2)
		upgrade_magic_mumber(1)