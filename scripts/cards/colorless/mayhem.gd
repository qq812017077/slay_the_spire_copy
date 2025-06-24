class_name Mayhem
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Mayhem"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Mayhem", card_string.name, "colorless/power/mayhem", 2, card_string.description, CardType.POWER, CardColor.COLORLESS, CardRarity.RARE, CardTarget.SELF)

	
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number