class_name Survivor
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Survivor"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Survivor", card_string.name, "green/skill/survivor", 1, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.BASIC, CardTarget.SELF)

	self.base_block = 8