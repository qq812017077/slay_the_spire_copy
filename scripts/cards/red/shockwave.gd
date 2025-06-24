class_name Shockwave
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Shockwave"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Shockwave", card_string.name, "red/skill/shockwave", 2, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.UNCOMMON, CardTarget.ALL_ENEMIES)


	self.exhaust = true
	self.base_magic_number = 3
	self.magic_number = self.base_magic_number