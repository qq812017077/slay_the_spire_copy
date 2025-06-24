class_name FollowUp
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "FollowUp"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("FollowUp", card_string.name, "purple/attack/follow_up", 1, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 7