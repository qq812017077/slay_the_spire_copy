class_name FearNoEvil
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "FearNoEvil"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("FearNoEvil", card_string.name, "purple/attack/fear_no_evil", 1, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 8