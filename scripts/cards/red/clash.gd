class_name Clash
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Clash"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Clash", card_string.name, "red/attack/clash", 0, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 14


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(4)