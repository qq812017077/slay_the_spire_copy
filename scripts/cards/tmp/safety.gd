class_name Safety
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Safety"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Safety", card_string.name, "colorless/skill/safety", 0, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.SPECIAL, CardTarget.SELF)

	self.base_block = 12
	self.self_retain = true
	self.exhaust = true