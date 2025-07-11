class_name Bash
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Bash"
#static var cardStrings: CardString = CardGame.languagePack.getCardStrings("Strike_R") 


func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Bash", card_string.name, "red/attack/bash" , 2, card_string.description, CardType.ATTACK, CardColor.RED, CardRarity.COMMON, CardTarget.ENEMY)

	self.base_damage = 6
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number



func upgrade() -> void:
	if not upgraded:
		upgrade_name()
		upgrade_damage(2)
		upgrade_magic_mumber(1)