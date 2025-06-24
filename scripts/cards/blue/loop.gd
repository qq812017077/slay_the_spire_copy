class_name Loop
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Loop"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Loop", card_string.name, "blue/power/loop", 1, card_string.description, CardType.POWER, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_magic_number = 1
	self.magic_number = self.base_magic_number