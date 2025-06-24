class_name ReachHeaven
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "ReachHeaven"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("ReachHeaven", card_string.name, "purple/attack/reach_heaven", 0, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.COMMON, CardTarget.NONE)

	self.card_to_preview = ThroughViolence.new()

	self.base_damage = 10