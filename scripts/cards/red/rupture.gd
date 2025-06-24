class_name Rupture
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Rupture"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Rupture", card_string.name, "red/power/rupture", 1, card_string.description, CardType.POWER, CardColor.RED, CardRarity.UNCOMMON, CardTarget.SELF)

	
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number