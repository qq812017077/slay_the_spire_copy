class_name Cleave
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Cleave"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Cleave", card_string.name, "red/attack/cleave", 1, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.COMMON, CardTarget.ALL_ENEMIES)

	self.base_damage = 8
	self.is_multi_damage = true