class_name Predator
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Predator"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Predator", card_string.name, "green/attack/predator", 2, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 15


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(5)