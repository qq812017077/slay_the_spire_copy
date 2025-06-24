class_name BecomeAlmighty
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "BecomeAlmighty"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("BecomeAlmighty", card_string.name, "colorless/power/become_almighty", -2, card_string.description, CardType.POWER, CardColor.COLORLESS, CardRarity.SPECIAL, CardTarget.NONE)
	
	
	self.base_magic_number = 3
	self.magic_number = self.base_magic_number