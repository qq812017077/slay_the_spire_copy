class_name BattleTrance
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Battle Trance"
#static var cardStrings: CardString = CardGame.languagePack.getCardStrings("Strike_R") 


func _init() -> void:
    if card_string == null:
        card_string = CardGame.languagePack.get_card_string(ID)
    super("Battle Trance", card_string.name, "red/skill/battle_trance", 0, card_string.description, CardType.SKILL, CardColor.RED, CardRarity.UNCOMMON, CardTarget.NONE)
        
    self.base_magic_number = 3
    self.magic_number = self.base_magic_number