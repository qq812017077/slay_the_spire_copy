class_name SelfRepair
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Self Repair"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Self Repair", card_string.name, "blue/power/self_repair", 1, card_string.description, CardType.POWER, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_magic_number = 7
	self.magic_number = self.base_magic_number

	# self.tags.append(CardTag.HEALING)