class_name Skim
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Skim"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Skim", card_string.name, "blue/skill/skim", 1, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.NONE)

	self.base_magic_number = 3
	self.magic_number = self.base_magic_number

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)