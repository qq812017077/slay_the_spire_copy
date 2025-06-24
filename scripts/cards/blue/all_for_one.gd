class_name AllForOne
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "All For One"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("All For One", card_string.name, "blue/attack/all_for_one", 2, card_string.description, CardType.ATTACK, CardColor.BLUE, CardRarity.RARE, CardTarget.ENEMY)

	self.base_damage = 10