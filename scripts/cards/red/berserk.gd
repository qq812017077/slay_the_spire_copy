class_name Berserk
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Berserk"
#static var cardStrings: CardString = CardGame.languagePack.getCardStrings("Strike_R") 


func _init() -> void:
    if card_string == null:
        card_string = CardGame.languagePack.get_card_string(ID)
    super("Berserk", card_string.name, "red/power/berserk", 0, card_string.description, CardType.POWER, CardColor.RED, CardRarity.RARE, CardTarget.SELF)
        
    self.base_magic_number = 2
    self.magic_number = self.base_magic_number