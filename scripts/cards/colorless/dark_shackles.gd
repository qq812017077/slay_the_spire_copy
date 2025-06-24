class_name DarkShackles
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Dark Shackles"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Dark Shackles", card_string.name, "colorless/skill/dark_shackles", 0, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.UNCOMMON, CardTarget.ENEMY)

	
	self.exhaust = true
	self.base_magic_number = 9
	self.magic_number = self.base_magic_number