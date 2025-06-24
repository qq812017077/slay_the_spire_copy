class_name PoisonedStab
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Poisoned Stab"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Poisoned Stab", card_string.name, "green/attack/poisoned_stab", 1, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 6
	self.base_magic_number = 4
	self.magic_number = self.base_magic_number