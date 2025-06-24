class_name InfiniteBlades
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Infinite Blades"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Infinite Blades", card_string.name, "green/power/infinite_blades", 1, card_string.description, CardType.POWER, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.SELF)


	self.card_to_preview = Shiv.new()