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
