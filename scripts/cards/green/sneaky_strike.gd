class_name SneakyStrike
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Underhanded Strike"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Underhanded Strike", card_string.name, "green/attack/sneaky_strike", 2, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 12
	self.tags.append(CardTag.STRIKE)