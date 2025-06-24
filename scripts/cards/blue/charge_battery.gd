class_name ChargeBattery
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "ChargeBattery"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("ChargeBattery", card_string.name, "blue/skill/charge_battery", 0, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.COMMON, CardTarget.NONE)
