class_name SashWhip
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "SashWhip"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("SashWhip", card_string.name, "purple/attack/sash_whip", 1, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.COMMON, CardTarget.ENEMY)
	
	self.base_damage = 8
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number