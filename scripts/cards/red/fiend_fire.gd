class_name FiendFire
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Fiend Fire"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Fiend Fire", card_string.name, "red/attack/fiend_fire", 2, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.RARE, CardTarget.ENEMY)

	self.base_damage = 7
	self.exhaust = true


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(3)