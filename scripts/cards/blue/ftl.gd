class_name FTL
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "FTL"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("FTL", card_string.name, "blue/attack/ftl", 0, card_string.description, CardType.ATTACK, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 5
	self.base_magic_number = 3
	self.magic_number = self.base_magic_number

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(1)
		upgrade_magic_mumber(1)