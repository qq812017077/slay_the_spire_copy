class_name HyperBeam
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Hyperbeam"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Hyperbeam", card_string.name, "blue/attack/hyper_beam", 2, card_string.description, CardType.ATTACK, CardColor.BLUE, CardRarity.RARE, CardTarget.ALL_ENEMIES)


	self.base_damage = 26
	self.is_multi_damage = true
	self.base_magic_number = 3
	self.magic_number = self.base_magic_number