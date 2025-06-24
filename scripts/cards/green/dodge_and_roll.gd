class_name DodgeAndRoll
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Dodge and Roll"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Dodge and Roll", card_string.name, "green/skill/dodge_and_roll", 1, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.COMMON, CardTarget.SELF)
	
	self.base_block = 4
