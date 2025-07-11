class_name MultiCast
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Multi-Cast"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Multi-Cast", card_string.name, "blue/skill/multicast", -1, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.RARE, CardTarget.NONE)

	self.show_evoke_value = true

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		rawDescription = card_string.upgrade_description
		initialize_description()