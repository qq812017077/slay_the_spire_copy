class_name BladeDance
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Blade Dance"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Blade Dance", card_string.name, "green/skill/blade_dance", 1, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.COMMON, CardTarget.NONE)

	self.base_magic_number = 3
	self.magic_number = self.base_magic_number
	self.card_to_preview = Shiv.new()
