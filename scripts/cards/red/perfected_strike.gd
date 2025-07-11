class_name PerfectedStrike
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Perfected Strike"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Perfected Strike", card_string.name, "red/attack/perfected_strike", 2, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 6
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number
	self.tags.append(CardTag.STRIKE)



func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)
		rawDescription = card_string.upgrade_description
		initialize_description()