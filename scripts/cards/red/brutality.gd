class_name Brutality
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Brutality"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Brutality", card_string.name, "red/power/brutality", 0, card_string.description, CardType.POWER, CardColor.RED, CardRarity.RARE, CardTarget.SELF)
