class_name BattleHymn
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "BattleHymn"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("BattleHymn", card_string.name, "purple/power/battle_hymn", 1, card_string.description, CardType.POWER, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.base_magic_number = 1
	self.magic_number = self.base_magic_number
	self.card_to_preview = Smite.new()


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		is_innate = true
		self.rawDescription = card_string.upgrade_description
		initialize_description()