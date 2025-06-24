class_name Slimed
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Slimed"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Slimed", card_string.name, "status/slimed", 1, card_string.description, CardType.STATUS, CardColor.COLORLESS, CardRarity.COMMON, CardTarget.SELF)

	self.exhaust = true