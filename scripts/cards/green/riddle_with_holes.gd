class_name RiddleWithHoles
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Riddle With Holes"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Riddle With Holes", card_string.name, "green/attack/riddle_with_holes", 2, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 3