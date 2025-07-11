class_name Vigilance
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Vigilance"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Vigilance", card_string.name, "purple/skill/vigilance", 2, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.BASIC, CardTarget.SELF)

	self.base_block = 8
	self.block = self.base_block


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_block(4)