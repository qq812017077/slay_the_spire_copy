class_name LockOn
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Lockon"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Lockon", card_string.name, "blue/attack/lock_on", 1, card_string.description, CardType.ATTACK, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 8
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number