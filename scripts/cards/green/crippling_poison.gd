class_name CripplingPoison
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Crippling Poison"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Crippling Poison", card_string.name, "green/skill/crippling_poison", 2, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.ALL_ENEMIES)

	self.base_magic_number = 4
	self.magic_number = self.base_magic_number
	self.exhaust = true