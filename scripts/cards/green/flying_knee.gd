class_name FlyingKnee
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Flying Knee"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Flying Knee", card_string.name, "green/attack/flying_knee", 1, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 8


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(3)