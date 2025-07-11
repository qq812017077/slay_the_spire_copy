class_name Crescendo
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Crescendo"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Crescendo", card_string.name, "purple/skill/crescendo", 1, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.COMMON, CardTarget.SELF)

	self.exhaust = true
	self.self_retain = true


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_base_cost(0)