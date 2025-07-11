class_name Hologram
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Hologram"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Hologram", card_string.name, "blue/skill/hologram", 1, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.COMMON, CardTarget.SELF)

	self.base_block = 3
	self.exhaust = true

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(2)
		exhaust = false
		rawDescription = card_string.upgrade_description
		initialize_description()