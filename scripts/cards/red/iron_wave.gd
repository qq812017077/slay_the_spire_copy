class_name IronWave
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Iron Wave"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Iron Wave", card_string.name, "red/attack/iron_wave", 1, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 5
	self.base_block = 5
