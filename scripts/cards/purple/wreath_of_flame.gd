class_name WreathOfFlame
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "WreathOfFlame"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("WreathOfFlame", card_string.name, "purple/skill/wreathe_of_flame", 1, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.SELF)

	
	self.base_magic_number = 5
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(3)