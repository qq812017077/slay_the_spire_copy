class_name Writhe
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Writhe"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Writhe", card_string.name, "curse/writhe", -2, card_string.description, CardType.CURSE, CardColor.CURSE, CardRarity.CURSE, CardTarget.NONE)

	
	self.is_innate = true