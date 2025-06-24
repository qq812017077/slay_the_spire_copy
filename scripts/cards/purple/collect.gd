class_name Collect
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Collect"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Collect", card_string.name, "purple/skill/collect", -1, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.card_to_preview = Miracle.new()
	self.card_to_preview.upgrade()
	self.exhaust = true