extends Node

@export var attack_card_prefab: PackedScene = null
@export var skill_card_prefab: PackedScene = null
@export var power_card_prefab: PackedScene = null
@export var card_container: Node  = null
@export var card_count: int = 5
@export var card_theme: Theme = null

var cards: Array[CardWidget] = []
func _ready() -> void:
	if attack_card_prefab == null:
		push_error("Card prefab is not set.")
		return
	
	if card_container == null:
		# try to get first grid container in the scene
		card_container = get_tree().get_root().get_node("GridContainer")
		if card_container == null:
			push_error("Card container is not set and no GridContainer found in the scene.")
			return
	
	for i in range(card_count):
		add_single_card(StrikeRed.new())
#		add_single_card(StrikeGreen.new())
#		add_single_card(StrikeBlue.new())
	
	for i in range(card_count):
		add_single_card(DefendRed.new())
	
	add_single_card(Bash.new())
	add_single_card(Barricade.new())
	add_single_card(Offering.new())

func add_single_card(_card: AbstractCard) -> void:
	var card_instance: Node = get_card_prefab(_card.type).instantiate()
	if not card_instance:
		push_error("Failed to instantiate card prefab.")
		return
	card_container.add_child(card_instance)
	card_instance.name = "Card_" + str(cards.size())
	var card : CardWidget = card_instance as CardWidget
	card.load_card(_card)
	cards.append(card)

func get_card_prefab(card_type: AbstractCard.CardType) -> PackedScene:
	if card_type == AbstractCard.CardType.ATTACK:
		return attack_card_prefab
	if card_type == AbstractCard.CardType.POWER:
		return power_card_prefab
	
	return skill_card_prefab if skill_card_prefab else attack_card_prefab
