class_name Brilliance
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Brilliance"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Brilliance", card_string.name, "purple/attack/brilliance", 1, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.RARE, CardTarget.ENEMY)

	self.base_damage = 12
	self.base_magic_number = 0
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(4)