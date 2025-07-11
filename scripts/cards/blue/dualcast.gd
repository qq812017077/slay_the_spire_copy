class_name Dualcast
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Dualcast"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Dualcast", card_string.name, "blue/skill/dualcast", 1, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.BASIC, CardTarget.NONE)

	self.show_evoke_value = true


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_base_cost(0)