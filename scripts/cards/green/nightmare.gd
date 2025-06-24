class_name Nightmare
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Night Terror"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Night Terror", card_string.name, "green/skill/nightmare", 3, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.RARE, CardTarget.NONE)

	self.base_magic_number = 3
	self.magic_number = self.base_magic_number
	self.exhaust = true