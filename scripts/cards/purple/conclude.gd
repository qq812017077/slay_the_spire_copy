class_name Conclude
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Conclude"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Conclude", card_string.name, "purple/attack/conclude", 1, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.ALL_ENEMIES)

	self.base_damage = 12
	self.is_multi_damage = true