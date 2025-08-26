class_name GameActionManager
extends Object

enum Phase {WAITING_ON_USER, EXECUTING_ACTIONS}

var actions: Array[AbstractGameAction] = []
var next_combat_actions: Array[AbstractGameAction] = []
var pre_turn_actions: Array[AbstractGameAction] = []

var card_queue: Array[CardQueueItem] = []
var monster_queue: Array[MonsterQueueItem] = []

var cur_action: AbstractGameAction = null
var previous_action: AbstractGameAction = null

var last_card: AbstractCard = null

var phase : Phase = Phase.WAITING_ON_USER
var using_card: bool = false
var has_control: bool = false
var is_combating: bool :
	get:
		return CardGame.dungeon_main_screen.dungeon.cur_room_node.room.phase == AbstractRoom.RoomPhase.COMBAT

func update(delta: float) -> void:
	match phase:
		Phase.WAITING_ON_USER:
			get_next_action()
		Phase.EXECUTING_ACTIONS:
			execute_action(delta)

func get_next_action():
	if not actions.is_empty():
		cur_action = actions.pop_front()
		phase = Phase.EXECUTING_ACTIONS
		has_control = true
	elif not pre_turn_actions.is_empty():
		cur_action = pre_turn_actions.pop_front()
		phase = Phase.EXECUTING_ACTIONS
		has_control = true
	elif not card_queue.is_empty():
		using_card = true
		var card: AbstractCard = card_queue[0].card
		if not card:
			call_end_of_turn_actions()
		elif card == last_card:
			last_card = null

		if card_queue.size() == 1 and card_queue[0].is_end_turn_auto_play:
			# todo: relic Unceasing Top
			pass
		
		var can_play_card: bool = false
		if card:
			card.is_in_auto_play = card_queue[0].auto_play_card

			if card_queue[0].random_target:
				card_queue[0].monster = CardGame.dungeon_main_screen.get_random_monster()
			
func execute_action(delta: float):
	if cur_action and not cur_action.is_done:
		cur_action.update(delta)
	else:
		previous_action = cur_action
		cur_action =null
		get_next_action()

		if cur_action == null and (is_combating and not using_card):
			phase = Phase.WAITING_ON_USER
			CardGame.dungeon_main_screen.refresh_player()
			has_control = false
		using_card = false




func add_to_bottom(action: AbstractGameAction):
	if is_combating:
		actions.push_back(action)

func add_to_top(action: AbstractGameAction):
	if is_combating:
		actions.push_front(action)

func add_to_turn_start(action: AbstractGameAction):
	if is_combating:
		pre_turn_actions.push_front(action)


func add_to_next_combat(action: AbstractGameAction):
	next_combat_actions.append(action)

func use_next_combat_action() :
	for action in next_combat_actions:
		add_to_bottom(action)

	next_combat_actions.clear()


func add_card_queue_item(c: CardQueueItem, in_front_of_queue: bool = false) -> void:
	if in_front_of_queue:
		card_queue.push_front(c)
	else:
		card_queue.push_back(c)

func remove_from_queue(c: AbstractCard) -> void:
	var idx: int = card_queue.find_custom(func (v) : return v.card == c)
	if idx != -1:
		card_queue.remove_at(idx)

func clear_post_combat_actions() -> void:
	# remove all actions that are not combat actions
	var i: int = 0
	while i < actions.size():
		# if actions[i] is HealAction or actions[i] is GainBlockAction or actions[i] is UseCardAction:
		# 	continue
		if actions[i].action_type == AbstractGameAction.ActionType.DAMAGE:
			continue
		actions.remove_at(i)
		i -= 1

func call_end_of_turn_actions():
	var room : AbstractRoom = CardGame.dungeon_main_screen.dungeon.cur_room_node.room

	room.apply_end_of_turn_relic()
	room.apply_end_of_turn_pre_card_powers()

	add_to_bottom(TriggerEndOfTurnOrbsAction.new())

	CardGame.dungeon_main_screen.player.on_end_of_turn()

