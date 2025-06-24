class_name DeepBreath
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Deep Breath"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Deep Breath", card_string.name, "colorless/skill/deep_breath", 0, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.UNCOMMON, CardTarget.SELF)

	
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number