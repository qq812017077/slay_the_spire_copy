class_name SadisticNature
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Sadistic Nature"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Sadistic Nature", card_string.name, "colorless/power/sadistic_nature", 0, card_string.description, CardType.POWER, CardColor.COLORLESS, CardRarity.RARE, CardTarget.SELF)

	
	self.base_magic_number = 5
	self.magic_number = self.base_magic_number
	
func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(2)