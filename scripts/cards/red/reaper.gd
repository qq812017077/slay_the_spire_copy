class_name Reaper
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Reaper"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Reaper", card_string.name, "red/attack/reaper", 2, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.RARE, CardTarget.ALL_ENEMIES)


	self.base_damage = 4
	self.is_multi_damage = true
	self.exhaust = true

	self.tags.append(CardTag.HEALING)


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(1)