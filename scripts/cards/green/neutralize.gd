class_name Neutralize
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Neutralize"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Neutralize", card_string.name, "green/attack/neutralize", 0, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.BASIC, CardTarget.ENEMY)

	self.base_damage = 3
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(1)
		upgrade_magic_mumber(1)