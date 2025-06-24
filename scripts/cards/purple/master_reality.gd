class_name MasterReality
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "MasterReality"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("MasterReality", card_string.name, "purple/power/master_reality", 1, card_string.description, CardType.POWER, CardColor.PURPLE, CardRarity.RARE, CardTarget.SELF)

