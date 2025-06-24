class_name BowlingBash
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "BowlingBash"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("BowlingBash", card_string.name, "purple/attack/bowling_bash", 1, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 7