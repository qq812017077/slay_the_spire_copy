class_name Outmaneuver
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Outmaneuver"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Outmaneuver", card_string.name, "green/skill/outmaneuver", 1, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.COMMON, CardTarget.NONE)
