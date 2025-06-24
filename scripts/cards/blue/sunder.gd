class_name Sunder
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Sunder"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Sunder", card_string.name, "blue/attack/sunder", 3, card_string.description, CardType.ATTACK, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 24