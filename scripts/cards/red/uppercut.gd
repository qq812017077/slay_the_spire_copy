class_name Uppercut
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Uppercut"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Uppercut", card_string.name, "red/attack/uppercut", 2, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.UNCOMMON, CardTarget.ENEMY)


	self.base_damage = 13
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)