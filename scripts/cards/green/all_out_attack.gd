class_name AllOutAttack
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "All Out Attack"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("All Out Attack", card_string.name, "green/attack/all_out_attack", 1, card_string.description, CardType.ATTACK, CardColor.GREEN, CardRarity.UNCOMMON, CardTarget.ALL_ENEMIES)

	self.base_damage = 10
	self.is_multi_damage = true