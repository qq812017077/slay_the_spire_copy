class_name CardGroup
extends Object

enum CardGroupType {DRAW_PILE, MASTER_DECK, HAND, DISCARD_PILE, EXHAUST_PILE, CARD_POOL, UNSPECIFIED}


var card_group_type: CardGroupType
var group: Array[AbstractCard] = []
var queued: Array[AbstractCard] = []
var inHand: Array[AbstractCard] = []

func _init(group_type: CardGroupType) -> void:
	card_group_type = group_type

# public AbstractCard getRandomCard(boolean useRng) {
#   if (useRng) {
#	 return this.group.get(AbstractDungeon.cardRng.random(this.group.size() - 1));
#   }
#   return this.group.get(MathUtils.random(this.group.size() - 1));
# }

func size() -> int:
	return group.size()

func add_to_top(card: AbstractCard) -> void:
	group.push_back(card)

func add_to_bottom(card: AbstractCard) -> void:
	group.push_front(card)


func clear():
	group.clear()

func get_top_card() -> AbstractCard:
	return group.back()

func get_bottom_card() -> AbstractCard:
	return group.front()

func pop_top_card() -> AbstractCard:
	return group.pop_back()

func pop_bottom_card() -> AbstractCard:
	return group.pop_front()

func get_n_card_from_top(n: int) -> AbstractCard:
	return group[group.size() - 1 - n]

func get_random_card(useRng: bool) -> AbstractCard:
	if useRng:
		return group.get(CardGame.dungeon_main_screen.dungeon.cardRng.randi_range(0, group.size() - 1))
	return group.get(randi_range(0, group.size() - 1))

func get_random_card_by_rarity(useRng: bool, rarity: AbstractCard.CardRarity) -> AbstractCard:
	var rarity_cards = group.filter(func(c): return c.rarity == rarity)
	rarity_cards.sort()

	if useRng:
		return rarity_cards.get(CardGame.dungeon_main_screen.dungeon.cardRng.randi_range(0, rarity_cards.size() - 1))
	return rarity_cards.get(randi_range(0, rarity_cards.size() - 1))

func get_random_card_by_type(useRng: bool, type: AbstractCard.CardType) -> AbstractCard:
	var type_cards = group.filter(func(c): return c.type == type)
	type_cards.sort()

	if useRng:
		return type_cards.get(CardGame.dungeon_main_screen.dungeon.cardRng.randi_range(0, type_cards.size() - 1))
	return type_cards.get(randi_range(0, type_cards.size() - 1))

func shuffle(rng: RandomNumberGenerator = null) -> void:
	if rng == null:
		group.shuffle()
	else:
		RandomHelper.array_shuffle(rng, group)
func remove_card(card: AbstractCard) -> void:
	group.erase(card)
	if card_group_type == CardGroupType.MASTER_DECK:
		pass

func initialize_deck(master_deck: CardGroup) -> void:
	clear()
	var group_copy: Array[AbstractCard] = master_deck.group.duplicate()
	RandomHelper.array_shuffle(CardGame.dungeon_main_screen.dungeon.shuffleRng, group_copy)
	
	var place_on_top: Array[AbstractCard] = []

	for c: AbstractCard in group_copy:
		if c.is_innate:
			place_on_top.append(c)
			continue
		
		# if c.inBottleFlame || c.inBottleLightning || c.inBottleTornado:
		# 	place_on_top.append(c)
		# 	continue
		
		add_to_top(c)
	
	for c: AbstractCard in place_on_top:
		add_to_top(c)
	
	var diff: int = place_on_top.size() - CardGame.dungeon_main_screen.player.master_hand_size
	if diff > 0:
		CardGame.action_manager.add_to_turn_start(DrawCardAction.new(CardGame.dungeon_main_screen.player,diff))
