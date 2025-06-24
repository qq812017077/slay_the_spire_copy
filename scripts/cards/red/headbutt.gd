class_name Headbutt
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Headbutt"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Headbutt", card_string.name, "red/attack/headbutt", 1, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.COMMON, CardTarget.ENEMY)
	
	self.base_damage = 9