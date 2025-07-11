class_name BulletTime
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Bullet Time"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Bullet Time", card_string.name, "green/skill/bullet_time", 3, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.RARE, CardTarget.NONE)




func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_base_cost(2)