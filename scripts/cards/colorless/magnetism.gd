class_name Magnetism
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Magnetism"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Magnetism", card_string.name, "colorless/power/magnetism", 0, card_string.description, CardType.POWER, CardColor.COLORLESS, CardRarity.RARE, CardTarget.SELF)

	
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number