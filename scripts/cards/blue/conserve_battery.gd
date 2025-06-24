class_name ConserveBattery
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Conserve Battery"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Conserve Battery", card_string.name, "blue/skill/charge_battery", 1, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.COMMON, CardTarget.SELF)

	self.base_block = 7