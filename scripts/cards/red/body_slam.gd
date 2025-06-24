class_name BodySlam
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Body Slam"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Body Slam", card_string.name, "red/attack/body_slam", 1, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 0
