class_name SweepingBeam
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Sweeping Beam"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Sweeping Beam", card_string.name, "blue/attack/sweeping_beam", 1, card_string.description, CardType.ATTACK, CardColor.BLUE, CardRarity.COMMON, CardTarget.ALL_ENEMIES)

	self.base_damage = 6
	self.is_multi_damage = true
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(3)