class_name SandsOfTime
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "SandsOfTime"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("SandsOfTime", card_string.name, "purple/attack/sands_of_time", 4, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 20
	self.self_retain = true