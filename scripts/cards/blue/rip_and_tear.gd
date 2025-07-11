class_name RipAndTear
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Rip and Tear"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Rip and Tear", card_string.name, "blue/attack/rip_and_tear", 1, card_string.description, CardType.ATTACK, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.ALL_ENEMIES)

	self.base_damage = 7
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(2)