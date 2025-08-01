class_name Wallop
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Wallop"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Wallop", card_string.name, "purple/attack/wallop", 2, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 9


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(3)