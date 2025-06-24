class_name JustLucky
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "JustLucky"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("JustLucky", card_string.name, "purple/attack/just_lucky", 0, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 3
	self.base_block = 2
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number