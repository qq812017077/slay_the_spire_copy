class_name Dash
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Dash"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Dash", card_string.name, "green/attack/dash", 2, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 10
	self.base_block = 10


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(3)
		upgrade_block(3)