class_name Bite
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Bite"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Bite", card_string.name, "colorless/attack/bite", 1, card_string.description, CardType.ATTACK, CardColor.COLORLESS, CardRarity.SPECIAL, CardTarget.ENEMY)

	self.base_damage = 7
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number
	self.tags.append(CardTag.HEALING)

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(1)
		upgrade_magic_mumber(1)