class_name Backstab
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Backstab"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Backstab", card_string.name, "green/attack/backstab", 0, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 11
	self.is_innate = true
	self.exhaust = true