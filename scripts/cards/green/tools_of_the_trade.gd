class_name ToolsOfTheTrade
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Tools of the Trade"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Tools of the Trade", card_string.name, "green/power/tools_of_the_trade", 1, card_string.description, CardType.POWER, CardColor.GREEN, CardRarity.RARE, CardTarget.SELF)




func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_base_cost(0)