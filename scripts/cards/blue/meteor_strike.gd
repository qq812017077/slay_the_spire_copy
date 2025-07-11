class_name MeteorStrike
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Meteor Strike"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Meteor Strike", card_string.name, "blue/attack/meteor_strike", 5, card_string.description, CardType.ATTACK, CardColor.BLUE, CardRarity.RARE, CardTarget.ENEMY)

	self.base_damage = 24
	self.base_magic_number = 3
	self.magic_number = self.base_magic_number

func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(6)
		# rawDescription = card_string.upgrade_description
		# initialize_description()