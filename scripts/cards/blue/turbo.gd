class_name Turbo
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Turbo"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Turbo", card_string.name, "blue/skill/turbo", 0, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.COMMON, CardTarget.SELF)


	self.base_magic_number = 2
	self.magic_number = self.base_magic_number
	# self.cards_to_previews = VoidCard.new()