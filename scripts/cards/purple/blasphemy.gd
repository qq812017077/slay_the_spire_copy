class_name Blasphemy
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Blasphemy"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Blasphemy", card_string.name, "purple/skill/blasphemy", 1, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.RARE, CardTarget.SELF)

	self.exhaust = true