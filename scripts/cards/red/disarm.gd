class_name Disarm
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Disarm"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Disarm", card_string.name, "red/skill/disarm", 1, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_magic_number = 2
	self.magic_number = self.base_magic_number
	self.exhaust = true


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)