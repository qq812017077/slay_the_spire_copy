class_name MasterOfStrategy
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Master of Strategy"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Master of Strategy", card_string.name, "colorless/skill/master_of_strategy", 0, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.RARE, CardTarget.NONE)

	
	self.base_magic_number = 3
	self.magic_number = self.base_magic_number
	self.exhaust = true

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)