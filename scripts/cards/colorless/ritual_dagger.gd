class_name RitualDagger
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "RitualDagger"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("RitualDagger", card_string.name, "colorless/attack/ritual_dagger", 1, card_string.description, CardType.ATTACK, CardColor.COLORLESS, CardRarity.SPECIAL, CardTarget.ENEMY)

	self.misc = 15
	self.base_magic_number = 3
	self.magic_number = self.base_magic_number
	self.base_damage = self.misc
	self.exhaust = true