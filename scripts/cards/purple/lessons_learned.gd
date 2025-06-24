class_name LessonsLearned
extends AbstractCard

static var card_string: CardString = null
static var ID :String = "LessonLearned"



func _init() -> void:
	if card_string == null:
		card_string = CardGame.languagePack.get_card_string(ID)
	super("LessonLearned", card_string.name, "purple/attack/lessons_learned", 2, card_string.description, CardType.ATTACK, CardColor.PURPLE, CardRarity.RARE, CardTarget.ENEMY)

	self.base_damage = 10
	self.exhaust = true
	self.tags.append(CardTag.HEALING)