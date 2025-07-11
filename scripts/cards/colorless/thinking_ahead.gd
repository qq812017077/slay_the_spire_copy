class_name ThinkingAhead
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Thinking Ahead"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Thinking Ahead", card_string.name, "colorless/skill/thinking_ahead", 0, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.RARE, CardTarget.NONE)

	self.exhaust = true
	
func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		self.exhaust = false
		rawDescription = card_string.upgrade_description
		initialize_description()