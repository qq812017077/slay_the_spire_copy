class_name Adrenaline
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Adrenaline"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Adrenaline", card_string.name, "green/skill/adrenaline", 0, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.RARE, CardTarget.SELF)

	self.exhaust = true