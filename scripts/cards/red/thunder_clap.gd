class_name ThunderClap
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Thunderclap"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Thunderclap", card_string.name, "red/attack/thunder_clap", 1, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.COMMON, CardTarget.ALL_ENEMIES)


	self.is_multi_damage = true
	self.base_damage = 4



func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(3)