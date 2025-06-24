class_name Rainbow
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Rainbow"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Rainbow", card_string.name, "blue/skill/rainbow", 2, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.RARE, CardTarget.SELF)

	self.show_evoke_value = true
	self.show_evoke_orb_count = 3
	self.exhaust = true