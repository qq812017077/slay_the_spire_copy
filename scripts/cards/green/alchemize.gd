class_name Alchemize
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Venomology"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Venomology", card_string.name, "green/skill/alchemize", 1, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.RARE, CardTarget.SELF)

	self.exhaust = true
	self.tags.append(CardTag.HEALING)


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_base_cost(0)