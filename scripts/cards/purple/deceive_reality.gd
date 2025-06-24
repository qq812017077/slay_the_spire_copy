class_name DeceiveReality
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "DeceiveReality"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("DeceiveReality", card_string.name, "purple/skill/deceive_reality", 1, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_block = 8
	self.card_to_preview = Safety.new()