class_name Blind
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Blind"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Blind", card_string.name, "colorless/skill/blind", 0, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.UNCOMMON, CardTarget.ENEMY)

	
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number