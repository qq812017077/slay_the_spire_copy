class_name GlassKnife
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Glass Knife"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Glass Knife", card_string.name, "green/attack/glass_knife", 1, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.RARE, CardTarget.ENEMY)

	self.base_damage = 8


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(4)