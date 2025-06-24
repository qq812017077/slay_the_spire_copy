class_name DualWield
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Dual Wield"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Dual Wield", card_string.name, "red/skill/dual_wield", 1, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.UNCOMMON, CardTarget.NONE)

	self.base_magic_number = 1
	self.magic_number = self.base_magic_number