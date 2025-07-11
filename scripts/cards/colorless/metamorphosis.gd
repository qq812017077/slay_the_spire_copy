class_name Metamorphosis
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Metamorphosis"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Metamorphosis", card_string.name, "colorless/skill/metamorphosis", 2, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.RARE, CardTarget.NONE)

	
	self.base_magic_number = 3
	self.magic_number = self.base_magic_number
	self.exhaust = true

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(2)