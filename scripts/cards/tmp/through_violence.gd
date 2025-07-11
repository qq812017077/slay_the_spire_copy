class_name ThroughViolence
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "ThroughViolence"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("ThroughViolence", card_string.name, "colorless/attack/through_violence", 0, card_string.description, CardType.ATTACK, CardColor.COLORLESS, CardRarity.SPECIAL, CardTarget.ENEMY)

	self.base_damage = 20
	self.self_retain = true
	self.exhaust = true


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(10)