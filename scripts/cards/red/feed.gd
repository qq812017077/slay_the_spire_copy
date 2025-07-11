class_name Feed
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Feed"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Feed", card_string.name, "red/attack/feed", 1, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.RARE, CardTarget.ENEMY)

	self.base_damage = 10
	self.exhaust = true
	self.base_magic_number = 3
	self.magic_number = self.base_magic_number

	self.tags.append(CardTag.HEALING)


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(2)
		upgrade_magic_mumber(1)