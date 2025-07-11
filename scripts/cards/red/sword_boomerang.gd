class_name SwordBoomerang
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Sword Boomerang"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Sword Boomerang", card_string.name, "red/attack/sword_boomerang", 1, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.COMMON, CardTarget.ALL_ENEMIES)

	
	self.base_damage = 3
	self.base_magic_number = 3
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)