class_name TheBomb
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "The Bomb"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("The Bomb", card_string.name, "colorless/skill/the_bomb", 2, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.RARE, CardTarget.SELF)

	
	self.base_magic_number = 40
	self.magic_number = self.base_magic_number
	
func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(10)