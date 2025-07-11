class_name Miracle
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Miracle"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Miracle", card_string.name, "colorless/skill/miracle", 0, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.UNCOMMON, CardTarget.SELF)

	
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number
	self.exhaust = true

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)