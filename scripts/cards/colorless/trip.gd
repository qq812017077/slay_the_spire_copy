class_name Trip
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Trip"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Trip", card_string.name, "colorless/skill/trip", 0, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.UNCOMMON, CardTarget.ENEMY)

	
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number