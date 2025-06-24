class_name CutThroughFate
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "CutThroughFate"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("CutThroughFate", card_string.name, "purple/attack/cut_through_fate", 1, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 7
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number