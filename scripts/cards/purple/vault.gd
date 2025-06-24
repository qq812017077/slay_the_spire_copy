class_name Vault
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Vault"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Vault", card_string.name, "purple/skill/vault", 3, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.RARE, CardTarget.ALL_ENEMIES)

	self.exhaust = true