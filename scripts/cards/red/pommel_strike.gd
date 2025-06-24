class_name PommelStrike
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Pommel Strike"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Pommel Strike", card_string.name, "red/attack/pommel_strike", 1, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.COMMON, CardTarget.ENEMY)


	
	self.base_damage = 9
	self.base_magic_number = 1
	self.magic_number = self.base_magic_number
	self.tags.append(CardTag.STRIKE)