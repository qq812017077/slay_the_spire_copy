class_name Purity
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Purity"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Purity", card_string.name, "colorless/skill/purity", 0, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.UNCOMMON, CardTarget.NONE)

	
	self.base_magic_number = 3
	self.magic_number = self.base_magic_number
	self.exhaust = true