class_name Panache
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Panache"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Panache", card_string.name, "colorless/power/panache", 0, card_string.description, CardType.POWER, CardColor.COLORLESS, CardRarity.COMMON, CardTarget.NONE)


	
	self.base_magic_number = 10
	self.magic_number = self.base_magic_number

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(4)