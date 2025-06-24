class_name Calm
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Calm"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Calm", card_string.name, "colorless/skill/calm", -2, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.COMMON, CardTarget.NONE)
