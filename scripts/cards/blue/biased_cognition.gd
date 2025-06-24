class_name BiasedCognition
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Biased Cognition"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Biased Cognition", card_string.name, "blue/power/biased_cognition", 1, card_string.description, CardType.POWER, CardColor.BLUE, CardRarity.RARE, CardTarget.SELF)

	self.base_magic_number = 4
	self.magic_number = self.base_magic_number