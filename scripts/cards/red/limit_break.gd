class_name LimitBreak
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Limit Break"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Limit Break", card_string.name, "red/skill/limit_break", 1, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.RARE, CardTarget.SELF)

	self.exhaust = true


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		self.exhaust = false
		rawDescription = card_string.upgrade_description
		initialize_description()