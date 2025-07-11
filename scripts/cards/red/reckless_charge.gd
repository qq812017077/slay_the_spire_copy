class_name RecklessCharge
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Reckless Charge"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Reckless Charge", card_string.name, "red/attack/reckless_charge", 0, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 7
	self.card_to_preview = Dazed.new()


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(3)