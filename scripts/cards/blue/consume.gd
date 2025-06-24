class_name Consume
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Consume"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Consume", card_string.name, "blue/skill/consume", 2, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_magic_number = 2
	self.magic_number = self.base_magic_number