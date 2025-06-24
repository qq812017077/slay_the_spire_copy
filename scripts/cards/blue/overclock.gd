class_name Overclock
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Steam Power"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Steam Power", card_string.name, "blue/skill/overclock", 0, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_magic_number = 2
	self.magic_number = self.base_magic_number

	# self.cards_to_preview = Burn.new()