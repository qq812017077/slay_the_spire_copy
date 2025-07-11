class_name Reboot
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Reboot"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Reboot", card_string.name, "blue/skill/reboot", 0, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.RARE, CardTarget.SELF)

	self.base_magic_number = 4
	self.magic_number = self.base_magic_number
	self.exhaust = true

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(2)