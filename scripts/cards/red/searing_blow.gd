class_name SearingBlow
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Searing Blow"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Searing Blow", card_string.name, "red/attack/searing_blow", 2, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 12
	self.times_upgrades = 0


func upgrade() -> void:
	upgraded = true
	upgrade_damage(4 + times_upgrades)
	times_upgrades+=1
	name = card_string.name + "+" + str(times_upgrades)
	