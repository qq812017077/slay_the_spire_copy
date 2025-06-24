class_name LiveForever
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "LiveForever"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("LiveForever", card_string.name, "colorless/power/live_forever", -2, card_string.description, CardType.POWER, CardColor.COLORLESS, CardRarity.SPECIAL, CardTarget.NONE)

	
	self.base_magic_number = 6
	self.magic_number = self.base_magic_number