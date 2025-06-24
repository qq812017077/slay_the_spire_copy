class_name Fission
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Fission"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Fission", card_string.name, "blue/skill/fission", 0, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.RARE, CardTarget.NONE)

	self.base_magic_number = 1
	self.magic_number = self.base_magic_number
	self.exhaust = true