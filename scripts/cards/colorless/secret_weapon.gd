class_name SecretWeapon
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Secret Weapon"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Secret Weapon", card_string.name, "colorless/skill/secret_weapon", 0, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.RARE, CardTarget.NONE)

	self.exhaust = true