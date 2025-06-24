class_name CreativeAI
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Creative AI"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Creative AI", card_string.name, "blue/power/creative_ai", 3, card_string.description, CardType.POWER, CardColor.BLUE, CardRarity.RARE, CardTarget.SELF)

	self.base_magic_number = 1
	self.magic_number = self.base_magic_number