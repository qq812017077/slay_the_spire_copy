class_name Expunger
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Expunger"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Expunger", card_string.name, "colorless/attack/expunger", 1, card_string.description, CardType.ATTACK, CardColor.COLORLESS, CardRarity.SPECIAL, CardTarget.ENEMY)

	self.base_damage = 9