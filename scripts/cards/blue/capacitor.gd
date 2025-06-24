class_name Capacitor
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Capacitor"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Capacitor", card_string.name, "blue/power/capacitor", 1, card_string.description, CardType.POWER, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_magic_number = 2
	self.magic_number = self.base_magic_number