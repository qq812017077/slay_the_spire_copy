class_name Insight
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Insight"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Insight", card_string.name, "colorless/skill/insight", 0, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.SPECIAL, CardTarget.SELF)

	
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number
	self.exhaust = true
	self.self_retain = true


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)