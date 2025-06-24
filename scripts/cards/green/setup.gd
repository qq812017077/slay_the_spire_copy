class_name Setup
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Setup"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Setup", card_string.name, "green/skill/setup", 1, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.NONE)
