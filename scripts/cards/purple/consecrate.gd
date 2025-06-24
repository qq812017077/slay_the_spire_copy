class_name Consecrate
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Consecrate"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Consecrate", card_string.name, "purple/attack/consecrate", 0, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.COMMON, CardTarget.ALL_ENEMIES)

	self.base_damage = 5
	self.is_multi_damage = true