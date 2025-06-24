class_name GrandFinale
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Grand Finale"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Grand Finale", card_string.name, "green/attack/grand_finale", 0, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.RARE, CardTarget.ALL_ENEMIES)

	self.base_damage = 50
	self.is_multi_damage = true