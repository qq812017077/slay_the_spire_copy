class_name Wrath
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Wrath"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Wrath", card_string.name, "colorless/skill/wrath", -2, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.COMMON, CardTarget.NONE)
