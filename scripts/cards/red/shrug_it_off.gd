class_name ShrugItOff
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Shrug It Off"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Shrug It Off", card_string.name, "red/skill/shrug_it_off", 1, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.COMMON, CardTarget.SELF)


	self.base_block = 8


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_block(3)