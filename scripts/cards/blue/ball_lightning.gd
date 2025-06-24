class_name BallLightning
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Ball Lightning"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Ball Lightning", card_string.name, "blue/attack/ball_lightning", 1, card_string.description, CardType.ATTACK, CardColor.BLUE, CardRarity.COMMON, CardTarget.ENEMY)


	self.show_evoke_value = true
	self.show_evoke_orb_count = 1
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number
	self.base_damage = 7