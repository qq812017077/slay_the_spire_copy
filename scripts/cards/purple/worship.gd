class_name Worship
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Worship"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Worship", card_string.name, "purple/skill/worship", 2, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.SELF)

	
	self.base_magic_number = 5
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		self_retain = true
		self.rawDescription = card_string.upgrade_description
		initialize_description()