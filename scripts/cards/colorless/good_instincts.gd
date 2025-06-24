class_name GoodInstincts
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Good Instincts"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Good Instincts", card_string.name, "colorless/skill/good_instincts", 0, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_block = 6