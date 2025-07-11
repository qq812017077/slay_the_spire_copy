class_name ThunderStrike
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Thunder Strike"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Thunder Strike", card_string.name, "blue/attack/thunder_strike", 3, card_string.description, CardType.ATTACK, CardColor.BLUE, CardRarity.RARE, CardTarget.ALL_ENEMIES)

	self.base_magic_number = 0
	self.magic_number = self.base_magic_number
	self.base_damage = 7
	# self.tags.append(CardTag.STRIKE)

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(2)