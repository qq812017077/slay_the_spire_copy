class_name Protect
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Protect"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Protect", card_string.name, "purple/skill/protect", 2, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.COMMON, CardTarget.SELF)

	self.base_block = 12
	self.self_retain = true