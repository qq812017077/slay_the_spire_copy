class_name Violence
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Violence"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Violence", card_string.name, "colorless/skill/violence", 0, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.UNCOMMON, CardTarget.ENEMY)

	
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number
	
func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)