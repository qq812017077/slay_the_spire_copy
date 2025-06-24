class_name Burst
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Burst"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Burst", card_string.name, "green/skill/burst", 1, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.RARE, CardTarget.SELF)


	self.base_magic_number = 1
	self.magic_number = self.base_magic_number