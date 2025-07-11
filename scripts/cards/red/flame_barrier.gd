class_name FlameBarrier
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Flame Barrier"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Flame Barrier", card_string.name, "red/skill/flame_barrier", 2, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_block = 12
	self.base_magic_number = 4
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_block(4)
		upgrade_magic_mumber(2)