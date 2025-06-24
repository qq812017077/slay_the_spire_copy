class_name Electrodynamics
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Electrodynamics"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Electrodynamics", card_string.name, "blue/power/electrodynamics", 2, card_string.description, CardType.POWER, CardColor.BLUE, CardRarity.RARE, CardTarget.SELF)

	self.base_magic_number = 2
	self.magic_number = self.base_magic_number