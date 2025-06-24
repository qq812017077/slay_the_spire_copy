class_name Burn
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Burn"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Burn", card_string.name, "status/burn", -2, card_string.description, CardType.STATUS, CardColor.COLORLESS, CardRarity.COMMON, CardTarget.NONE)

	self.base_magic_number = 2
	self.magic_number = self.base_magic_number