class_name Carnage
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Carnage"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Carnage", card_string.name, "red/attack/carnage", 2, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 20
	self.is_ethereal = true