class_name MindBlast
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Mind Blast"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Mind Blast", card_string.name, "colorless/attack/mind_blast", 2, card_string.description, CardType.ATTACK, CardColor.COLORLESS, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.is_innate = true
	self.base_damage = 0