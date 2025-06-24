class_name Clothesline
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Clothesline"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Clothesline", card_string.name, "red/attack/clothesline", 2, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 12
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number