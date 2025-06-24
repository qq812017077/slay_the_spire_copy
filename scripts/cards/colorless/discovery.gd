class_name Discovery
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Discovery"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Discovery", card_string.name, "colorless/skill/discovery", 1, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.UNCOMMON, CardTarget.SELF)

	self.exhaust = true