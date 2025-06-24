class_name Acrobatics
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Acrobatics"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Acrobatics", card_string.name, "green/skill/acrobatics", 1, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.COMMON, CardTarget.NONE)

	self.base_magic_number = 3
	self.magic_number = self.base_magic_number