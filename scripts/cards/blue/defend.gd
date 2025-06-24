class_name Defend
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Defend"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Defend", card_string.name, "blue/skill/defend", 0, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.COMMON, CardTarget.NONE)
