class_name SeverSoul
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Sever Soul"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Sever Soul", card_string.name, "red/attack/sever_soul", 2, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.UNCOMMON, CardTarget.ENEMY)


	self.base_damage = 16