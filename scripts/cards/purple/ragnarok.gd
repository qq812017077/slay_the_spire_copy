class_name Ragnarok
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Ragnarok"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Ragnarok", card_string.name, "purple/attack/ragnarok", 3, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.RARE, CardTarget.ALL_ENEMIES)

	self.base_damage = 5
	self.base_magic_number = 5
	self.magic_number = self.base_magic_number