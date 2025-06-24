class_name MasterfulStab
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Masterful Stab"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Masterful Stab", card_string.name, "green/attack/masterful_stab", 0, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 12