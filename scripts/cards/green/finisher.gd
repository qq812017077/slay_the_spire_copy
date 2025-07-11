class_name Finisher
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Finisher"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Finisher", card_string.name, "green/attack/finisher", 1, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 6


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(2)