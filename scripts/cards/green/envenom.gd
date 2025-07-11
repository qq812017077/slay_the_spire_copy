class_name Envenom
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Envenom"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Envenom", card_string.name, "green/power/envenom", 2, card_string.description, CardType.POWER, CardColor.GREEN, CardRarity.RARE, CardTarget.SELF)



func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_base_cost(1)