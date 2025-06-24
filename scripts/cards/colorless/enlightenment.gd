class_name Enlightenment
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Enlightenment"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Enlightenment", card_string.name, "colorless/skill/enlightenment", 0, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.UNCOMMON, CardTarget.SELF)
