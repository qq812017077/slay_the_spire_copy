class_name Alpha
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Alpha"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Alpha", card_string.name, "purple/skill/alpha", 1, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.RARE, CardTarget.NONE)

	self.card_to_preview = Beta.new()