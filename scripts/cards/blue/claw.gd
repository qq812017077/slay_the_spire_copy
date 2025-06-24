class_name Claw
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Gash"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Gash", card_string.name, "blue/attack/claw", 0, card_string.description, CardType.ATTACK, CardColor.BLUE, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 3
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number