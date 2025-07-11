class_name ThirdEye
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "ThirdEye"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("ThirdEye", card_string.name, "purple/skill/third_eye", 0, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.COMMON, CardTarget.SELF)

	self.base_block = 7
	self.base_magic_number = 3
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_block(2)
		upgrade_magic_mumber(2)