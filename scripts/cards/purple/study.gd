class_name Study
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Study"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Study", card_string.name, "purple/power/study", 2, card_string.description, CardType.POWER, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.SELF)

	
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number
	self.card_to_preview = Insight.new()