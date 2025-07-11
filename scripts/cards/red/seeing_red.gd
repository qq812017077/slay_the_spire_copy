class_name SeeingRed
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Seeing Red"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Seeing Red", card_string.name, "red/skill/seeing_red", 1, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.UNCOMMON, CardTarget.NONE)


	self.exhaust = true


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_base_cost(0)