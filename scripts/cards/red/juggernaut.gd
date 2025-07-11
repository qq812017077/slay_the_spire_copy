class_name Juggernaut
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Juggernaut"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Juggernaut", card_string.name, "red/power/juggernaut", 2, card_string.description, CardType.POWER, CardColor.RED, CardRarity.RARE, CardTarget.SELF)


	self.base_magic_number = 5
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(2)