class_name Forcefield
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Forcefield"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Forcefield", card_string.name, "blue/skill/forcefield", 0, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.COMMON, CardTarget.NONE)
