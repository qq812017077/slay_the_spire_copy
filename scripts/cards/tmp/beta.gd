class_name Beta
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Beta"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Beta", card_string.name, "colorless/skill/beta", 2, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.SPECIAL, CardTarget.NONE)

	self.card_to_preview = Omega.new()
	self.exhaust = true