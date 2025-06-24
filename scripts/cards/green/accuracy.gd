class_name Accuracy
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Accuracy"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Accuracy", card_string.name, "green/power/accuracy", 1, card_string.description, CardType.POWER, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_magic_number = 4
	self.magic_number = self.base_magic_number
	self.card_to_preview = Shiv.new()