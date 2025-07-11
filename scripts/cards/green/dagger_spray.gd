class_name DaggerSpray
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Dagger Spray"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Dagger Spray", card_string.name, "green/attack/dagger_spray", 1, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.COMMON, CardTarget.ALL_ENEMIES)

	self.base_damage = 4
	self.is_multi_damage = true


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(2)