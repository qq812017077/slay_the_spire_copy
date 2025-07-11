class_name Reflex
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Reflex"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Reflex", card_string.name, "green/skill/reflex", 0, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.NONE)

	self.base_magic_number = 2
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)
		self.rawDescription = card_string.upgrade_description
		initialize_description()