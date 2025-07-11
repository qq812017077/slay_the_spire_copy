class_name Immolate
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Immolate"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Immolate", card_string.name, "red/attack/immolate", 2, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.RARE, CardTarget.ALL_ENEMIES)

	self.base_damage = 21
	self.is_multi_damage = true
	self.card_to_preview = Burn.new()


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(7)