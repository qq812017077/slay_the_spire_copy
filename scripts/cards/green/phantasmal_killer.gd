class_name PhantasmalKiller
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Phantasmal Killer"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Phantasmal Killer", card_string.name, "green/skill/phantasmal_killer", 1, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.RARE, CardTarget.SELF)
