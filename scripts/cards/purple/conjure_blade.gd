class_name ConjureBlade
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "ConjureBlade"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("ConjureBlade", card_string.name, "purple/skill/conjure_blade", -1, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.RARE, CardTarget.SELF)

	self.card_to_preview = Expunger.new()
	self.exhaust = true


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		self.rawDescription = card_string.upgrade_description
		initialize_description()