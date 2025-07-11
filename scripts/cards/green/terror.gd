class_name Terror
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Terror"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Terror", card_string.name, "green/skill/terror", 1, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.exhaust = true



func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_base_cost(0)