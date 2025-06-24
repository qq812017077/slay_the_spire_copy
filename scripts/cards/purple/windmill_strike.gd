class_name WindmillStrike
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "WindmillStrike"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("WindmillStrike", card_string.name, "purple/attack/windmill_strike", 0, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 7
	self.base_magic_number = 4
	self.magic_number = self.base_magic_number
	self.self_retain = true
	self.tags.append(CardTag.STRIKE)