class_name Tantrum
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Tantrum"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Tantrum", card_string.name, "purple/attack/tantrum", 1, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.ENEMY)


	self.base_damage = 3
	self.base_magic_number = 3
	self.magic_number = self.base_magic_number
	self.shuffle_back_into_draw_pile = true
	


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)