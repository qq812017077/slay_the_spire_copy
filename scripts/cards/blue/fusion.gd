class_name Fusion
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Fusion"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Fusion", card_string.name, "blue/skill/fusion", 2, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_magic_number = 1
	self.magic_number = self.base_magic_number