class_name Eruption
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Eruption"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Eruption", card_string.name, "purple/attack/eruption", 2, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.BASIC, CardTarget.ENEMY)

	self.base_damage = 9


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_base_cost(1)