class_name PiercingWail
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "PiercingWail"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("PiercingWail", card_string.name, "green/skill/piercing_wail", 1, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.COMMON, CardTarget.ALL_ENEMIES)

	self.exhaust = true
	self.base_magic_number = 6
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(2)