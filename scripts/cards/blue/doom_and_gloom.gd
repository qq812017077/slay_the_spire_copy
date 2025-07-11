class_name DoomAndGloom
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Doom and Gloom"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Doom and Gloom", card_string.name, "blue/attack/doom_and_gloom", 2, card_string.description, CardType.ATTACK, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.ALL_ENEMIES)

	self.show_evoke_value = true
	self.show_evoke_orb_count = 1
	self.base_damage = 10
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number
	self.is_multi_damage = true

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(4)