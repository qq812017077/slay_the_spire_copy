class_name CalculatedGamble
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Calculated Gamble"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Calculated Gamble", card_string.name, "green/skill/calculated_gamble", 0, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.NONE)

	self.exhaust = true