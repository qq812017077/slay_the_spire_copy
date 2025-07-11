class_name Prostrate
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Prostrate"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Prostrate", card_string.name, "purple/skill/prostrate", 0, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.COMMON, CardTarget.SELF)

	self.base_magic_number = 2
	self.magic_number = self.base_magic_number
	self.base_block = 4
	self.block = self.base_block


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)