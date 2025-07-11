class_name GoForTheEyes
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Go for the Eyes"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Go for the Eyes", card_string.name, "blue/attack/go_for_the_eyes", 0, card_string.description, CardType.ATTACK, CardColor.BLUE, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 3
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(1)
		upgrade_magic_mumber(1)