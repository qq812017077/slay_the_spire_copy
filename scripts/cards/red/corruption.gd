class_name Corruption
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Corruption"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Corruption", card_string.name, "red/power/corruption", 3, card_string.description, CardType.POWER, CardColor.RED, CardRarity.RARE, CardTarget.SELF)

	self.base_magic_number = 3
	self.magic_number = self.base_magic_number