class_name EmptyFist
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "EmptyFist"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("EmptyFist", card_string.name, "purple/attack/empty_fist", 1, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 9
	self.tags.append(CardTag.EMPTY)