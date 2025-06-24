class_name Bloodletting
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Bloodletting"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Bloodletting", card_string.name, "red/skill/bloodletting", 0, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_magic_number = 2
	self.magic_number = self.base_magic_number