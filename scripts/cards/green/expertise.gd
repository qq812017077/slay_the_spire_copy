class_name Expertise
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Expertise"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Expertise", card_string.name, "green/skill/expertise", 1, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_magic_number = 6
	self.magic_number = self.base_magic_number