class_name PanicButton
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "PanicButton"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("PanicButton", card_string.name, "colorless/skill/panic_button", 0, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_block = 30
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number
	self.exhaust = true
	
func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_block(10)