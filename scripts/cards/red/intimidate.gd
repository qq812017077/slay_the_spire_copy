class_name Intimidate
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Intimidate"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Intimidate", card_string.name, "red/skill/intimidate", 0, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.UNCOMMON, CardTarget.ALL_ENEMIES)

	self.exhaust = true
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number