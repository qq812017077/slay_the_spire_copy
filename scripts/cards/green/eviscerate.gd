class_name Eviscerate
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Eviscerate"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Eviscerate", card_string.name, "green/attack/eviscerate", 3, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.ENEMY)
	
	self.base_damage = 7