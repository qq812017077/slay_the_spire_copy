class_name HelloWorld
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Hello World"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Hello World", card_string.name, "blue/power/hello_world", 0, card_string.description, CardType.POWER, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.SELF)


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		is_innate = true
		rawDescription = card_string.upgrade_description
		initialize_description()