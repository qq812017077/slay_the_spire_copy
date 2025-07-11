class_name Unload
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Unload"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Unload", card_string.name, "green/attack/unload", 1, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.RARE, CardTarget.ENEMY)

	self.base_damage = 14



func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(4)