class_name StrikePurple
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Strike_P"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Strike_P", card_string.name, "purple/attack/strike", 1, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.BASIC, CardTarget.ENEMY)

	self.base_damage = 6
	self.tags.append(CardTag.STRIKE)
	self.tags.append(CardTag.STARTER_STRIKE)


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(3)