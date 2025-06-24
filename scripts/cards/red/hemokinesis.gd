class_name Hemokinesis
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Hemokinesis"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Hemokinesis", card_string.name, "red/attack/hemokinesis", 1, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.UNCOMMON, CardTarget.ENEMY)


	self.base_damage = 15
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number