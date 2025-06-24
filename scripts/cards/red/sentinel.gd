class_name Sentinel
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Sentinel"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Sentinel", card_string.name, "red/skill/sentinel", 1, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.UNCOMMON, CardTarget.SELF)


	self.base_block = 5