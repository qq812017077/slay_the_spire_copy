class_name Streamline
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Streamline"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Streamline", card_string.name, "blue/attack/streamline", 2, card_string.description, CardType.ATTACK, CardColor.BLUE, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 11
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(5)
		initialize_description()