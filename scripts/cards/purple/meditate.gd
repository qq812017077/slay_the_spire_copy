class_name Meditate
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Meditate"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Meditate", card_string.name, "purple/skill/meditate", 1, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.NONE)

	self.base_magic_number = 1
	self.magic_number = self.base_magic_number