class_name LikeWater
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "LikeWater"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("LikeWater", card_string.name, "purple/power/like_water", 1, card_string.description, CardType.POWER, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.NONE)

	self.base_magic_number = 5
	self.magic_number = self.base_magic_number