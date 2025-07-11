class_name NoxiousFumes
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Noxious Fumes"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Noxious Fumes", card_string.name, "green/power/noxious_fumes", 1, card_string.description, CardType.POWER, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_magic_number = 2
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)