class_name Forethought
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Forethought"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Forethought", card_string.name, "colorless/skill/forethought", 0, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.UNCOMMON, CardTarget.NONE)
