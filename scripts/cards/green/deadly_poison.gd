class_name DeadlyPoison
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Deadly Poison"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Deadly Poison", card_string.name, "green/skill/deadly_poison", 1, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_magic_number = 5
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(2)