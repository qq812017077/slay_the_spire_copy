class_name Deflect
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Deflect"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Deflect", card_string.name, "green/skill/deflect", 0, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.COMMON, CardTarget.SELF)

	self.base_block = 4


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_block(3)