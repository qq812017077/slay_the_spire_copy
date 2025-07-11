class_name ColdSnap
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Cold Snap"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Cold Snap", card_string.name, "blue/attack/cold_snap", 0, card_string.description, CardType.ATTACK, CardColor.BLUE, CardRarity.COMMON, CardTarget.ENEMY)

	self.show_evoke_value = true
	self.show_evoke_orb_count = 1
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number
	self.base_damage = 6


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(3)