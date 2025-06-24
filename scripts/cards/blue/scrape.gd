class_name Scrape
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Scrape"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Scrape", card_string.name, "blue/attack/scrape", 1, card_string.description, CardType.ATTACK, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 7
	self.base_magic_number = 4
	self.magic_number = self.base_magic_number