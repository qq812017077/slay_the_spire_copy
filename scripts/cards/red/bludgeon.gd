class_name Bludgeon
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Bludgeon"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Bludgeon", card_string.name, "red/attack/bludgeon", 3, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.RARE, CardTarget.ENEMY)

	self.base_damage = 32


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(10)