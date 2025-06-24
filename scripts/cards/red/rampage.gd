class_name Rampage
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Rampage"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Rampage", card_string.name, "red/attack/rampage", 1, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 8
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number