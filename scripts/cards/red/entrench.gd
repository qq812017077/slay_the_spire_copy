class_name Entrench
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Entrench"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Entrench", card_string.name, "red/skill/entrench", 2, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.UNCOMMON, CardTarget.SELF)
	


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_base_cost(1)
		rawDescription = card_string.upgrade_description
		initialize_description()