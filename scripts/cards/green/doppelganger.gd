class_name Doppelganger
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Doppelganger"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Doppelganger", card_string.name, "green/skill/doppelganger", -1, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.RARE, CardTarget.SELF)

	self.exhaust = true