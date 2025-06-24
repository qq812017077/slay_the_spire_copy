class_name DefendRed
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Defend_R"
#static var cardStrings: CardString = CardGame.languagePack.getCardStrings("Strike_R") 


func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Defend_R", card_string.name, "red/skill/defend" , 1, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.COMMON, CardTarget.SELF)

	self.base_block = 5
	
