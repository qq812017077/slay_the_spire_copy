class_name WhiteNoise
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "White Noise"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("White Noise", card_string.name, "blue/skill/white_noise", 1, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.NONE)

	self.exhaust = true

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_base_cost(0)