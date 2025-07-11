class_name Concentrate
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Concentrate"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Concentrate", card_string.name, "green/skill/concentrate", 0, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_magic_number = 1
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(-1)
		initialize_description()