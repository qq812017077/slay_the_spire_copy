class_name QuickSlash
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Quick Slash"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Quick Slash", card_string.name, "green/attack/quick_slash", 1, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 8