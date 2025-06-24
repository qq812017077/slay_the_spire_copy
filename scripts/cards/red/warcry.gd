class_name Warcry
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Warcry"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Warcry", card_string.name, "red/skill/warcry", 0, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.COMMON, CardTarget.SELF)


	self.exhaust = true
	
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number