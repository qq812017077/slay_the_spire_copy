class_name FlyingSleeves
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "FlyingSleeves"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("FlyingSleeves", card_string.name, "purple/attack/flying_sleeves", 1, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 4
	self.self_retain = true


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(2)