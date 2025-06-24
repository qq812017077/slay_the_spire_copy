class_name PowerThrough
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Power Through"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Power Through", card_string.name, "red/skill/power_through", 1, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.UNCOMMON, CardTarget.SELF)


	self.base_block = 15
	self.card_to_preview = Wound.new()