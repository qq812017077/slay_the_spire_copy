class_name CorpseExplosion
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Corpse Explosion"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Corpse Explosion", card_string.name, "green/skill/corpse_explosion", 2, card_string.description, CardType.SKILL, CardColor.GREEN, CardRarity.RARE, CardTarget.ENEMY)

	self.base_magic_number = 6
	self.magic_number = self.base_magic_number


func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_magic_mumber(3)