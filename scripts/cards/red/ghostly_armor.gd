class_name GhostlyArmor
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Ghostly Armor"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Ghostly Armor", card_string.name, "red/skill/ghostly_armor", 1, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.UNCOMMON, CardTarget.SELF)

	self.is_ethereal = true
	self.base_block = 10


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_block(3)