class_name HeavyBlade
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Heavy Blade"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Heavy Blade", card_string.name, "red/attack/heavy_blade", 0, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.COMMON, CardTarget.ENEMY)


	self.base_damage = 14
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number