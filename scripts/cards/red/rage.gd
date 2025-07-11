class_name Rage
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Rage"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Rage", card_string.name, "red/skill/rage", 0, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.UNCOMMON, CardTarget.SELF)

	
	self.base_magic_number = 3
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(2)