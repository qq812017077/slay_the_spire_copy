class_name Panacea
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Panacea"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Panacea", card_string.name, "colorless/skill/panacea", 0, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.RARE, CardTarget.SELF)

	
	self.base_magic_number = 10
	self.magic_number = self.base_magic_number