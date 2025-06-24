class_name AutoShields
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Auto Shields"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Auto Shields", card_string.name, "blue/skill/auto_shields", 1, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_block = 11