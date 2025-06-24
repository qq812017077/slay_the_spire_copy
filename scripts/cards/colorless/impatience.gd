class_name Impatience
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Impatience"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Impatience", card_string.name, "colorless/skill/impatience", 0, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.UNCOMMON, CardTarget.NONE)

	
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number