class_name StormOfSteel
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Storm of Steel"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Storm of Steel", card_string.name, "green/skill/storm_of_steel", 1, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.RARE, CardTarget.NONE)

	self.card_to_preview = Shiv.new()


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		card_to_preview.upgrade()
		upgrade_magic_mumber(1)
		self.rawDescription = card_string.upgrade_description
		initialize_description()