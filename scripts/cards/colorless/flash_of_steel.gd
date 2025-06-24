class_name FlashOfSteel
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Flash of Steel"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Flash of Steel", card_string.name, "colorless/attack/flash_of_steel", 0, card_string.description, CardType.ATTACK, CardColor.COLORLESS, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 3