class_name Omega
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Omega"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Omega", card_string.name, "colorless/power/omega", 3, card_string.description, CardType.POWER, CardColor.COLORLESS, CardRarity.SPECIAL, CardTarget.SELF)

	
	self.base_magic_number = 50
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(10)