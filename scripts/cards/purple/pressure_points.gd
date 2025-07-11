class_name PressurePoints
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "PathToVictory"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("PathToVictory", card_string.name, "purple/skill/pressure_points", 1, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.COMMON, CardTarget.ENEMY)


	self.base_magic_number = 8
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(3)