class_name AscendersBane
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "AscendersBane"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("AscendersBane", card_string.name, "curse/ascenders_bane", -2, card_string.description, CardType.CURSE, CardColor.CURSE, CardRarity.SPECIAL, CardTarget.NONE)

	self.is_ethereal = true