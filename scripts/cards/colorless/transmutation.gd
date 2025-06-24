class_name Transmutation
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Transmutation"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Transmutation", card_string.name, "colorless/skill/transmutation", -1, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.RARE, CardTarget.SELF)

	self.exhaust = true