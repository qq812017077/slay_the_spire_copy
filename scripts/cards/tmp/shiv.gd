class_name Shiv
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Shiv"

static var UPG_ATTACK_DMG : int = 2


func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Shiv", card_string.name, "colorless/attack/shiv", 0, card_string.description, CardType.ATTACK, CardColor.COLORLESS, CardRarity.COMMON, CardTarget.NONE)


	self.base_damage = 4
	self.exhaust = true


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(2)