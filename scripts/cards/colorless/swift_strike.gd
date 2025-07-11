class_name SwiftStrike
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Swift Strike"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Swift Strike", card_string.name, "colorless/attack/swift_strike", 0, card_string.description, CardType.ATTACK, CardColor.COLORLESS, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 7
	self.tags.append(CardTag.STRIKE)
	
func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(3)