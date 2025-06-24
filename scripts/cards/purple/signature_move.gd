class_name SignatureMove
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "SignatureMove"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("SignatureMove", card_string.name, "purple/attack/signature_move", 2, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 30