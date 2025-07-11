class_name Tempest
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Tempest"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Tempest", card_string.name, "blue/skill/tempest", -1, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.show_evoke_value = true
	self.show_evoke_orb_count = 3
	self.exhaust = true

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		rawDescription = card_string.upgrade_description
		initialize_description()