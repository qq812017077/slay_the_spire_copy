class_name Anger
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Anger"
#static var cardStrings: CardString = CardGame.languagePack.getCardStrings("Strike_R") 


func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Anger", card_string.name, "red/attack/anger" , 0, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.COMMON, CardTarget.ENEMY)
	
	self.base_damage = 6



func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(2)