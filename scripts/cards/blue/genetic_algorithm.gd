class_name GeneticAlgorithm
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "Genetic Algorithm"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("Genetic Algorithm", card_string.name, "blue/skill/genetic_algorithm", 1, card_string.description, CardType.SKILL, CardColor.BLUE, CardRarity.UNCOMMON, CardTarget.SELF)

	self.misc = 1
	self.base_magic_number = 2
	self.magic_number = self.base_magic_number
	self.exhaust = true
	self.base_block = self.misc