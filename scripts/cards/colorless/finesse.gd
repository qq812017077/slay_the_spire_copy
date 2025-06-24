class_name Finesse
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Finesse"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Finesse", card_string.name, "colorless/skill/finesse", 0, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_block = 2