class_name Amplify
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Amplify"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Amplify", card_string.name, "blue/skill/amplify", 1, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.RARE, CardTarget.NONE)
	
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)
		rawDescription = card_string.upgrade_description
		initialize_description()
		
# func make_copy() -> AbstractCard:
# 	return Amplify.new() 