class_name Havoc
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Havoc"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Havoc", card_string.name, "red/skill/havoc", 1, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.COMMON, CardTarget.NONE)
