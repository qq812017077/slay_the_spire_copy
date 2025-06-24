class_name TrueGrit
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "True Grit"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("True Grit", card_string.name, "red/skill/true_grit", 1, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.COMMON, CardTarget.SELF)

	self.base_block = 7