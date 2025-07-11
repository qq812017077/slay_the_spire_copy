class_name Melter
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Melter"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Melter", card_string.name, "blue/attack/melter", 1, card_string.description, CardType.ATTACK, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 10

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(4)