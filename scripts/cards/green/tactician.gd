class_name Tactician
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Tactician"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Tactician", card_string.name, "green/skill/tactician", -2, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.NONE)

	self.base_magic_number = 1
	self.magic_number = self.base_magic_number