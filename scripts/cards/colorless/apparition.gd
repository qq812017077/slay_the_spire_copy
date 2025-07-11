class_name Apparition
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Ghostly"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Ghostly", card_string.name, "colorless/skill/apparition", 1, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.SPECIAL, CardTarget.SELF)

	self.exhaust = true
	self.is_ethereal = true

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		rawDescription = card_string.upgrade_description
		initialize_description()
		is_ethereal = false