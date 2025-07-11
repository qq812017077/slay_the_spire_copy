class_name DemonForm
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Demon Form"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Demon Form", card_string.name, "red/power/demon_form", 3, card_string.description, CardType.POWER, CardColor.RED, CardRarity.RARE, CardTarget.NONE)

	self.base_magic_number = 2
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)