class_name DoubleTap
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Double Tap"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Double Tap", card_string.name, "red/skill/double_tap", 1, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.RARE, CardTarget.SELF)

	self.base_magic_number = 1
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)
		rawDescription = card_string.upgrade_description
		initialize_description()