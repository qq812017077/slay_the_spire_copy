class_name FlurryOfBlows
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "FlurryOfBlows"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("FlurryOfBlows", card_string.name, "purple/attack/flurry_of_blows", 0, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 4


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(2)