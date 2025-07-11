class_name TalkToTheHand
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "TalkToTheHand"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("TalkToTheHand", card_string.name, "purple/attack/talk_to_the_hand", 1, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.UNCOMMON, CardTarget.ENEMY)

	self.base_damage = 5
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number
	self.exhaust = true


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(2)
		upgrade_magic_mumber(1)