class_name LegSweep
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Leg Sweep"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Leg Sweep", card_string.name, "green/skill/leg_sweep", 2, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_block = 11
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)
		upgrade_block(3)