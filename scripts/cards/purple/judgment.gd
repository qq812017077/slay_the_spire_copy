class_name Judgment
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Judgement"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Judgement", card_string.name, "purple/skill/judgment", 1, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.RARE, CardTarget.ENEMY)

	self.base_magic_number = 30
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(10)
		# self.rawDescription = card_string.upgrade_description
		# initialize_description()