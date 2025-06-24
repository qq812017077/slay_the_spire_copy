class_name Footwork
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Footwork"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Footwork", card_string.name, "green/power/footwork", 1, card_string.description, CardType.POWER, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_magic_number = 2
	self.magic_number = self.base_magic_number