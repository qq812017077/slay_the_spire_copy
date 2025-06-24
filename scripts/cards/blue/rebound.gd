class_name Rebound
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Rebound"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Rebound", card_string.name, "blue/attack/rebound", 1, card_string.description, CardType.ATTACK, CardColor.BLUE, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 9