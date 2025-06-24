class_name Reprogram
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Reprogram"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Reprogram", card_string.name, "blue/skill/reprogram", 1, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.NONE)

	self.base_magic_number = 1
	self.magic_number = self.base_magic_number