class_name EndlessAgony
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Endless Agony"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Endless Agony", card_string.name, "green/attack/endless_agony", 0, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 4
	self.exhaust = true


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(2)