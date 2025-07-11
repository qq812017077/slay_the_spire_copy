class_name EscapePlan
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Escape Plan"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Escape Plan", card_string.name, "green/skill/escape_plan", 0, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.SELF)
	
	self.base_block = 3


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_block(2)