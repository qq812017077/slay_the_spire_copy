class_name CoreSurge
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Core Surge"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Core Surge", card_string.name, "blue/attack/core_surge", 1, card_string.description, CardType.ATTACK, CardColor.BLUE, CardRarity.RARE, CardTarget.ENEMY)

	self.exhaust = true
	self.base_damage = 11
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(4)