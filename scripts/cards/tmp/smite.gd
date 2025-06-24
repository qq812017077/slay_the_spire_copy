class_name Smite
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Smite"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Smite", card_string.name, "colorless/attack/smite", 0, card_string.description, CardType.ATTACK, CardColor.COLORLESS, CardRarity.SPECIAL, CardTarget.ENEMY)

	self.base_damage = 12
	self.self_retain = true
	self.exhaust = true