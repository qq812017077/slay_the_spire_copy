class_name Recycle
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Recycle"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Recycle", card_string.name, "blue/skill/recycle", 1, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.SELF)
