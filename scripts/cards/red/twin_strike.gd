class_name TwinStrike
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Twin Strike"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Twin Strike", card_string.name, "red/attack/twin_strike", 1, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.COMMON, CardTarget.ENEMY)


	self.base_damage = 5
	self.tags.append(CardTag.STRIKE)


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(2)