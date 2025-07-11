class_name Bane
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Bane"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Bane", card_string.name, "green/attack/bane", 1, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.COMMON, CardTarget.ENEMY)


	self.base_damage = 7


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(3)