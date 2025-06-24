class_name Distraction
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Distraction"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Distraction", card_string.name, "green/skill/distraction", 1, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.NONE)

	self.exhaust = true