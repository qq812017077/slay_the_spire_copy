class_name DramaticEntrance
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Dramatic Entrance"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Dramatic Entrance", card_string.name, "colorless/attack/dramatic_entrance", 0, card_string.description, CardType.ATTACK, CardColor.COLORLESS, CardRarity.UNCOMMON, CardTarget.ALL_ENEMIES)

	self.base_damage = 8
	self.is_multi_damage = true
	self.exhaust = true
	self.is_innate = true