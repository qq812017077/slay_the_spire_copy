class_name StrikeBlue
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Strike_B"
#static var cardStrings: CardString = CardGame.languagePack.getCardStrings("Strike_R") 


func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Strike_B", card_string.name, "blue/attack/strike" , 1, card_string.description, CardType.ATTACK, CardColor.BLUE, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 6
	# self.tags.append(CardTag.STRIKE)
	# self.tags.append(CardTag.STARTER_STRIKE)

	
