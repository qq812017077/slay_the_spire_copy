class_name CloakAndDagger
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Cloak And Dagger"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Cloak And Dagger", card_string.name, "green/skill/cloak_and_dagger", 1, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.COMMON, CardTarget.SELF)

	self.base_block = 6
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number
	self.card_to_preview = Shiv.new()