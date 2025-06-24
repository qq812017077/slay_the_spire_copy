class_name Offering
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Offering"


func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Offering", card_string.name, "red/skill/offering" , 0, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.RARE, CardTarget.SELF)

	self.exhaust = true
	self.base_magic_number = 3
	self.magic_number = self.base_magic_number
	
