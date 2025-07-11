class_name BloodForBlood
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Blood for Blood"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Blood for Blood", card_string.name, "red/attack/blood_for_blood", 4, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.UNCOMMON, CardTarget.ENEMY)


	self.base_damage = 18


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_base_cost(cost -1)
		if cost < 0:
			cost = 0
		upgrade_damage(4)