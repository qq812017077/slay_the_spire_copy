class_name Impervious
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Impervious"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Impervious", card_string.name, "red/skill/impervious", 2, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.RARE, CardTarget.SELF)


	self.base_block = 30
	self.exhaust = true