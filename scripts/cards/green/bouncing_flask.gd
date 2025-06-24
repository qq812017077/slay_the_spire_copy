class_name BouncingFlask
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Bouncing Flask"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Bouncing Flask", card_string.name, "green/skill/bouncing_flask", 2, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.ALL_ENEMIES)

	self.base_magic_number = 3
	self.magic_number = self.base_magic_number