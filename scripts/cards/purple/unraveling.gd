class_name Unraveling
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Unraveling"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Unraveling", card_string.name, "purple/skill/unraveling", 2, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.RARE, CardTarget.NONE)

	self.exhaust = true