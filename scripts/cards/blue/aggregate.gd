class_name Aggregate
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Aggregate"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Aggregate", card_string.name, "blue/skill/aggregate", 1, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_magic_number = 4
	self.magic_number = self.base_magic_number