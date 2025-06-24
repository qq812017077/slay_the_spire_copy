class_name Wish
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Wish"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Wish", card_string.name, "purple/skill/wish", 3, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.RARE, CardTarget.NONE)


	self.base_damage = 3
	self.base_block = 6
	self.base_magic_number = 25
	self.magic_number = self.base_magic_number

	self.exhaust = true

	self.tags.append(CardTag.HEALING)