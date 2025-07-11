class_name Catalyst
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Catalyst"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Catalyst", card_string.name, "green/skill/catalyst", 1, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.exhaust = true


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		self.rawDescription = card_string.upgrade_description
		initialize_description()