class_name WheelKick
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "WheelKick"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("WheelKick", card_string.name, "purple/attack/wheel_kick", 2, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.ENEMY)


	self.base_damage = 15
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(5)