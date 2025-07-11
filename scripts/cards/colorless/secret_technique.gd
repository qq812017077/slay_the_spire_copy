class_name SecretTechnique
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Secret Technique"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Secret Technique", card_string.name, "colorless/skill/secret_technique", 0, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.RARE, CardTarget.NONE)

	self.exhaust = true
	
func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		exhaust = false
		rawDescription = card_string.upgrade_description
		initialize_description()