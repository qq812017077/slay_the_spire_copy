class_name StrikeGreen
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Strike_G"
#static var cardStrings: CardString = CardGame.languagePack.getCardStrings("Strike_R") 


func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Strike_G", card_string.name, "green/attack/strike" , 1, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.BASIC, CardTarget.ENEMY)

	self.base_damage = 6
	self.tags.append(CardTag.STRIKE)
	self.tags.append(CardTag.STARTER_STRIKE)
	



func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(3)