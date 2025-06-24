class_name JackOfAllTrades
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Jack Of All Trades"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Jack Of All Trades", card_string.name, "colorless/skill/jack_of_all_trades", 0, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.UNCOMMON, CardTarget.NONE)


	self.exhaust = true
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number