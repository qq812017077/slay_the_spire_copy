class_name AfterImage
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "After Image"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("After Image", card_string.name, "green/power/after_image", 1, card_string.description, CardType.POWER, CardColor.GREEN, CardRarity.RARE, CardTarget.SELF)

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		is_innate = true
		self.rawDescription = card_string.upgrade_description
		initialize_description()