class_name CrushJoints
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "CrushJoints"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("CrushJoints", card_string.name, "purple/attack/crush_joints", 1, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 8
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(2)
		upgrade_magic_mumber(1)