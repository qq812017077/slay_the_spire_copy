class_name Chrysalis
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Chrysalis"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Chrysalis", card_string.name, "colorless/skill/chrysalis", 2, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.RARE, CardTarget.NONE)

	
	self.base_magic_number = 3
	self.magic_number = self.base_magic_number
	self.exhaust = true