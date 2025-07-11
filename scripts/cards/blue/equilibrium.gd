class_name Equilibrium
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Undo"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Undo", card_string.name, "blue/skill/equilibrium", 2, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_block = 13
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_block(3)