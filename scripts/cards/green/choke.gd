class_name Choke
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Choke"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Choke", card_string.name, "green/attack/choke", 2, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 12
	self.base_magic_number = 3
	self.magic_number = self.base_magic_number