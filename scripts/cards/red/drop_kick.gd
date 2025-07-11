class_name DropKick
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Dropkick"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Dropkick", card_string.name, "red/attack/drop_kick", 1, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 5



func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(3)