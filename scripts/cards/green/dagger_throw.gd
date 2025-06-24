class_name DaggerThrow
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Dagger Throw"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Dagger Throw", card_string.name, "green/attack/dagger_throw", 1, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 9