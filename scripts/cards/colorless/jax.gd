class_name JAX
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "J.A.X."



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("J.A.X.", card_string.name, "colorless/skill/jax", 0, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.SPECIAL, CardTarget.SELF)

	
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number