class_name CarveReality
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "CarveReality"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("CarveReality", card_string.name, "purple/attack/carve_reality", 1, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 6
	self.card_to_preview = Smite.new()