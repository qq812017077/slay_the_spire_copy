class_name Leap
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Leap"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Leap", card_string.name, "blue/skill/leap", 1, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.COMMON, CardTarget.SELF)

	self.base_block = 9