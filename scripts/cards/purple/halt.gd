class_name Halt
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Halt"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Halt", card_string.name, "purple/skill/halt", 0, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.COMMON, CardTarget.SELF)

	self.base_block = 3
	self.block = self.base_block
	self.base_magic_number = 9
	self.magic_number = self.base_magic_number 



func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_block(1)
		base_magic_number = base_block + 6 + times_upgrades * 4
		upgraded_magic_number = upgraded_block