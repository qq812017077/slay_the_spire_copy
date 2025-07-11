class_name SecondWind
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Second Wind"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Second Wind", card_string.name, "red/skill/second_wind", 1, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_block = 5


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_block(2)