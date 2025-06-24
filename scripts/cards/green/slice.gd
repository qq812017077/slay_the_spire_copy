class_name Slice
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Slice"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Slice", card_string.name, "green/attack/slice", 0, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 6