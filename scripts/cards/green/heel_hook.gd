class_name HeelHook
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Heel Hook"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Heel Hook", card_string.name, "green/attack/heel_hook", 1, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 5


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(3)