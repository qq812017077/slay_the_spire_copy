class_name Swivel
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Swivel"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Swivel", card_string.name, "purple/skill/swivel", 2, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.SELF)

	
	self.base_block = 8
	self.magic_number = self.base_magic_number