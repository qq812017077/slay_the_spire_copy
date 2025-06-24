class_name Prepared
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Prepared"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Prepared", card_string.name, "green/skill/prepared", 0, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.COMMON, CardTarget.NONE)

	self.base_magic_number = 1
	self.magic_number = self.base_magic_number