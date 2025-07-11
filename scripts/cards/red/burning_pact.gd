class_name BurningPact
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Burning Pact"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Burning Pact", card_string.name, "red/skill/burning_pact", 1, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.UNCOMMON, CardTarget.NONE)

	self.base_magic_number = 2
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)