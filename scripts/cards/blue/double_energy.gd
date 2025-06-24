class_name DoubleEnergy
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Double Energy"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Double Energy", card_string.name, "blue/skill/double_energy", 1, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.exhaust = true