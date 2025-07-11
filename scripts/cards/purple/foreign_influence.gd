class_name ForeignInfluence
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "ForeignInfluence"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("ForeignInfluence", card_string.name, "purple/skill/foreign_influence", 0, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.NONE)

	self.exhaust = true


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		self.rawDescription = card_string.upgrade_description
		initialize_description()