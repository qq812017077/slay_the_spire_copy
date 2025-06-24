class_name Coolheaded
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Coolheaded"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Coolheaded", card_string.name, "blue/skill/coolheaded", 1, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.COMMON, CardTarget.SELF)

	self.show_evoke_value = true
	self.show_evoke_orb_count = 1
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number