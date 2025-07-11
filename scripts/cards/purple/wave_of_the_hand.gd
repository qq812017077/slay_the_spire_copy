class_name WaveOfTheHand
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "WaveOfTheHand"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("WaveOfTheHand", card_string.name, "purple/skill/wave_of_the_hand", 1, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.SELF)

	
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)