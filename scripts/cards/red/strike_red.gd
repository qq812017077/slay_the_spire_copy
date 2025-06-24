class_name StrikeRed
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Strike_R"
#static var cardStrings: CardString = CardGame.languagePack.getCardStrings("Strike_R") 


func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("StrikeRed", card_string.name, "red/attack/strike" , 1, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.COMMON, CardTarget.ENEMY)
	
	self.base_damage = 6
	self.tags.append(CardTag.STRIKE)
	self.tags.append(CardTag.STARTER_STRIKE)
	
