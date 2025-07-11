class_name Backflip
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Backflip"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Backflip", card_string.name, "green/skill/backflip", 1, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.COMMON, CardTarget.SELF)

	self.base_block = 5


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_block(3)