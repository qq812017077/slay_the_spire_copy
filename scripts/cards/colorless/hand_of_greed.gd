class_name HandOfGreed
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "HandOfGreed"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("HandOfGreed", card_string.name, "colorless/attack/hand_of_greed", 2, card_string.description, CardType.ATTACK, CardColor.COLORLESS, CardRarity.RARE, CardTarget.ENEMY)

	self.base_damage = 20
	
	self.base_magic_number = 20
	self.magic_number = self.base_magic_number