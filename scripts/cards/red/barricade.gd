class_name Barricade
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Barricade"
#static var cardStrings: CardString = CardGame.languagePack.getCardStrings("Strike_R") 


func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Barricade", card_string.name, "red/power/barricade" , 3, card_string.description, CardType.POWER, CardColor.RED, CardRarity.RARE, CardTarget.SELF)

