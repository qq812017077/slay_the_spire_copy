class_name Whirlwind
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Whirlwind"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Whirlwind", card_string.name, "red/attack/whirlwind", -1, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.UNCOMMON, CardTarget.ALL_ENEMIES)


	self.base_damage = 5
	self.is_multi_damage = true