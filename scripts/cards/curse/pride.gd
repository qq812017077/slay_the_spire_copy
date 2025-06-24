class_name Pride
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Pride"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Pride", card_string.name, "curse/pride", 1, card_string.description, CardType.CURSE, CardColor.CURSE, CardRarity.SPECIAL, CardTarget.NONE)

	self.exhaust = true
	self.is_innate = true