class_name Apotheosis
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Apotheosis"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Apotheosis", card_string.name, "colorless/skill/apotheosis", 2, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.RARE, CardTarget.NONE)

	self.exhaust = true

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_base_cost(1)