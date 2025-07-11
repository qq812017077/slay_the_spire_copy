class_name WellLaidPlans
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Well Laid Plans"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Well Laid Plans", card_string.name, "green/power/well_laid_plans", 1, card_string.description, CardType.POWER, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.NONE)

	
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number



func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)
		self.rawDescription = card_string.upgrade_description
		initialize_description()