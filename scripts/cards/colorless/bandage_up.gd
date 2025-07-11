class_name BandageUp
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Bandage Up"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Bandage Up", card_string.name, "colorless/skill/bandage_up", 0, card_string.description, CardType.SKILL, CardColor.COLORLESS, CardRarity.UNCOMMON, CardTarget.SELF)


	self.base_magic_number = 4
	self.magic_number = self.base_magic_number

	self.exhaust = true
	self.tags.append(CardTag.HEALING)

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(2)