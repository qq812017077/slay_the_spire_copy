class_name Exhume
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Exhume"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Exhume", card_string.name, "red/skill/exhume", 1, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.RARE, CardTarget.NONE)
	
	self.exhaust = true