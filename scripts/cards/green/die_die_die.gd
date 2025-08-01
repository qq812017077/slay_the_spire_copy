class_name DieDieDie
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Die Die Die"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Die Die Die", card_string.name, "green/attack/die_die_die", 1, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.RARE, CardTarget.ALL_ENEMIES)

	self.exhaust = true
	self.base_damage = 13
	self.is_multi_damage = true


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(4)