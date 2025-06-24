class_name WildStrike
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Wild Strike"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Wild Strike", card_string.name, "red/attack/wild_strike", 1, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 12
	self.tags.append(CardTag.STRIKE)
	self.card_to_preview = Wound.new()