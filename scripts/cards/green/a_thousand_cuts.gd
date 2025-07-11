class_name AThousandCuts
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "A Thousand Cuts"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("A Thousand Cuts", card_string.name, "green/power/a_thousand_cuts", 2, card_string.description, CardType.POWER, CardColor.GREEN, CardRarity.RARE, CardTarget.SELF)

	self.base_magic_number = 1
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)