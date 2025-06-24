class_name Blizzard
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Blizzard"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Blizzard", card_string.name, "blue/attack/blizzard", 1, card_string.description, CardType.ATTACK, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.ALL_ENEMIES)

	self.base_damage = 0
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number
	self.is_multi_damage = true