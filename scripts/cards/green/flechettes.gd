class_name Flechettes
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Flechettes"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Flechettes", card_string.name, "green/attack/flechettes", 1, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 4
