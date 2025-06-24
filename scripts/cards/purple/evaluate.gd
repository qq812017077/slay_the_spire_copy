class_name Evaluate
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Evaluate"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Evaluate", card_string.name, "purple/skill/evaluate", 1, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.COMMON, CardTarget.SELF)

	self.base_block = 6
	self.card_to_preview = Insight.new()