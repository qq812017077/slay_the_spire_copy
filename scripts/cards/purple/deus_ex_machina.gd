class_name DeusExMachina
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "DeusExMachina"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("DeusExMachina", card_string.name, "purple/skill/deus_ex_machina", -2, card_string.description, CardType.SKILL, CardColor.PURPLE, CardRarity.RARE, CardTarget.SELF)

	self.exhaust = true
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number
	self.card_to_preview = Miracle.new()


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(1)