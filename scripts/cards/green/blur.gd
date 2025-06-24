class_name Blur
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Blur"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Blur", card_string.name, "green/skill/blur", 1, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_block = 5