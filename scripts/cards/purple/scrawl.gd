class_name Scrawl
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Scrawl"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Scrawl", card_string.name, "purple/skill/scrawl", 1, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.RARE, CardTarget.NONE)

	self.exhaust = true