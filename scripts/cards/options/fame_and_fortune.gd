class_name FameAndFortune
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "FameAndFortune"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("FameAndFortune", card_string.name, "colorless/skill/fame_and_fortune", -2, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.SPECIAL, CardTarget.NONE)

	
	self.base_magic_number = 25
	self.magic_number = self.base_magic_number