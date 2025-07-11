class_name DarkEmbrace
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Dark Embrace"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Dark Embrace", card_string.name, "red/power/dark_embrace", 2, card_string.description, CardType.POWER, CardColor.RED, CardRarity.UNCOMMON, CardTarget.SELF)



func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_base_cost(1)