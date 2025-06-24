class_name Venomology
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Venomology"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Venomology", card_string.name, "green/power/venomology", 1, card_string.description, CardType.POWER, CardColor.GREEN, CardRarity.COMMON, CardTarget.NONE)

	self.base_magic_number = 1
	self.magic_number = self.base_magic_number