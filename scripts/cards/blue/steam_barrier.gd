class_name SteamBarrier
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Steam"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Steam", card_string.name, "blue/skill/steam_barrier", 0, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.COMMON, CardTarget.SELF)

	self.base_block = 6