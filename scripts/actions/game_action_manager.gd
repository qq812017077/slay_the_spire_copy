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
var turn_start_current_action: AbstractGameAction = null

var last_card: AbstractCard = null

# turn and combat
var turn_has_ended: bool = false
var turn: int = 0
var total_discarded_this_turn: int = 0
var total_discarded_this_combat: int = 0
var damage_received_this_turn: int = 0
var damage_received_this_combat: int = 0
var cards_played_this_turn: Array[AbstractCard] = []
var cards_played_this_combat: Array[AbstractCard] = []
var orbs_channeled_this_turn: Array[AbstractOrb] = []
var orbs_channeled_this_combat: Array[AbstractOrb] = []
var unique_stances_this_combat: Dictionary = {}

var energy_gain_this_combat: int = 0
var hp_loss_this_combat: int = 0

var phase: Phase = Phase.WAITING_ON_USER
var using_card: bool = false
var has_control: bool = false
var is_combating: bool:
	get:
		return CardGame.dungeon_main_screen.dungeon.cur_room_node.room.phase == AbstractRoom.RoomPhase.COMBAT

var monster_attacks_queued: bool = false


func update(delta: float) -> void:
	match phase:
		Phase.WAITING_ON_USER:
			get_next_action()
		Phase.EXECUTING_ACTIONS:
			execute_action(delta)

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

func use_next_combat_action():
	for action in next_combat_actions:
		add_to_bottom(action)

	next_combat_actions.clear()
			
func execute_action(delta: float):
	if cur_action and not cur_action.is_done:
		cur_action.update(delta)
	else:
		previous_action = cur_action
		cur_action = null
		get_next_action()

		if cur_action == null and (is_combating and not using_card):
			phase = Phase.WAITING_ON_USER
			CardGame.dungeon_main_screen.refresh_player()
			has_control = false
		using_card = false

	

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

			var player: AbstractPlayer = CardGame.dungeon_main_screen.player
			var room_monster: MonsterGroup = CardGame.dungeon_main_screen.get_cur_monsters()
			if card.random_target:
				card.monster = room_monster.get_raondom_monster(null, true,
				CardGame.dungeon_main_screen.dungeon.cardRandomRng)
			
			if card.can_use(player, card.monster) or card.dont_trigger_on_use_card:
				can_play_card = true
				
				if card.free_to_play():
					card.free_to_play_once = true
				card.energy_on_use = card_queue[0].energy_on_use
				if card.is_in_auto_play:
					card.ignore_energy_on_use = true
				else:
					card.ignore_energy_on_use = card_queue[0].ignore_energy_total
				
				if not card.dont_trigger_on_use_card:
					for p: AbstractPower in player.powers:
						p.on_play_card(card, card_queue[0].monster)
					
					for m: AbstractMonster in room_monster.monsters:
						for p: AbstractPower in m.powers:
							p.on_play_card(card, card_queue[0].monster)

					for r: AbstractRelic in player.relics:
						r.on_play_card(card, card_queue[0].monster)
					
					for b: AbstracBlight in player.blights:
						b.on_play_card(card, card_queue[0].monster)
					

					for c: AbstractCard in player.hand.group:
						c.on_play_card(card, card_queue[0].monster)
					
					for c: AbstractCard in player.discard_pile.group:
						c.on_play_card(card, card_queue[0].monster)
					

					for c: AbstractCard in player.draw_pile.group:
						c.on_play_card(card, card_queue[0].monster)
					
					player.cards_played_count_this_turn += 1
					cards_played_this_turn.append(card)
					cards_played_this_combat.append(card)
				
				if card.target == AbstractCard.CardTarget.ENEMY and (card_queue[0].monster == null or card_queue[0].monster.is_dead_or_escaped()):
					if card_queue[0].monster == null:
						pass
				else:
					player.use_card(card, card_queue[0].monster, card_queue[0].energy_on_use)
			else:
				pass
			
			card_queue.pop_front()
			if not can_play_card and card != null and card.is_in_auto_play:
				card.dont_trigger_on_use_card = true
				# add_to_bottom(UseCardAction.new(card))
			
	elif not monster_attacks_queued:
		monster_attacks_queued = true
		if CardGame.dungeon_main_screen.get_cur_room().skip_monster_turn:
			CardGame.dungeon_main_screen.get_cur_room().monsters.queue_monsters()
	
	elif not monster_queue.is_empty():
		var monster: AbstractMonster = monster_queue[0].monster
		if not monster.is_dead_or_escaped() or monster.half_dead:
			if monster.intent != AbstractMonster.Intent.NONE:
				add_to_bottom(ShowMoveNameAction.new(monster))
				add_to_bottom(IntentFlashAction.new(monster))
				pass
			
			monster.take_turn()
			monster.apply_turn_powers()
		
		monster_queue.pop_front()
		if monster_queue.is_empty():
			add_to_bottom(WaitAction.new(1.5))
	elif turn_has_ended and not CardGame.dungeon_main_screen.get_cur_monsters().are_monsters_basically_dead():
		if CardGame.dungeon_main_screen.get_cur_room().skip_monster_turn:
			CardGame.dungeon_main_screen.get_cur_room().monsters.apply_end_of_turn_powers()
		
		var player: AbstractPlayer = CardGame.dungeon_main_screen.player
		orbs_channeled_this_turn.clear()

		player.cards_played_count_this_turn = 0
		player.apply_start_of_turn_pre_draw_cards()
		player.apply_start_of_turn_cards()
		player.apply_start_of_turn_relics()
		player.apply_start_of_turn_powers()
		player.apply_start_of_turn_orbs()

		turn += 1
		CardGame.dungeon_main_screen.get_cur_room().skip_monster_turn = false
		turn_has_ended = false
		total_discarded_this_turn = 0
		cards_played_this_turn.clear()
		damage_received_this_turn = 0

		if not player.has_power(Barricade.ID) and not player.has_power(Blur.ID):
			# if player.has_relic(Calipers.ID):
			# 	player.lose_block(15)
			# else:
			player.lose_block()
		
		if not CardGame.dungeon_main_screen.get_cur_room().is_batter_over:
			add_to_bottom(DrawCardAction.new(null, player.game_hand_size, true))
			player.apply_start_of_turn_post_draw_relics()
			player.apply_start_of_turn_post_draw_powers()
			add_to_bottom(EnableEndTurnButtonAction.new())
			

func call_end_of_turn_actions():
	var room: AbstractRoom = CardGame.dungeon_main_screen.dungeon.cur_room_node.room

	room.apply_end_of_turn_relic()
	room.apply_end_of_turn_pre_card_powers()

	add_to_bottom(TriggerEndOfTurnOrbsAction.new())

	CardGame.dungeon_main_screen.player.on_end_of_turn()

func clean_card_queue():
	var i: int = card_queue.size() - 1
	while i >= 0:
		if CardGame.dungeon_main_screen.player.hand.group.has(card_queue[i].card):
			card_queue.remove_at(i)
		else:
			i -= 1

func is_empty() -> bool:
	return actions.is_empty()

func clear_next_room_combat_actions():
	next_combat_actions.clear()

func clear() -> void:
	actions.clear()
	pre_turn_actions.clear()
	cur_action = null
	previous_action = null
	turn_start_current_action = null


	cards_played_this_combat.clear()
	cards_played_this_turn.clear()
	orbs_channeled_this_turn.clear()
	orbs_channeled_this_combat.clear()
	unique_stances_this_combat.clear()
	card_queue.clear()

	energy_gain_this_combat = 0
	# this.mantraGained = 0
	damage_received_this_turn = 0
	damage_received_this_combat = 0
	hp_loss_this_combat = 0
	turn_has_ended = false
	turn = 1
	phase = Phase.WAITING_ON_USER
	total_discarded_this_turn = 0


func increase_discard(end_of_turn: bool = false) -> void:
	total_discarded_this_turn += 1
	if turn_has_ended and not end_of_turn:
		CardGame.dungeon_main_screen.player.update_cards_on_discard()

		for r: AbstractRelic in CardGame.dungeon_main_screen.player.relics:
			r.on_discard()
		
func update_energy_gain(energy_gain: int) -> void:
	energy_gain_this_combat += energy_gain


func add_card_queue_item(c: CardQueueItem, in_front_of_queue: bool = false) -> void:
	if in_front_of_queue:
		card_queue.push_front(c)
	else:
		card_queue.push_back(c)

func remove_from_queue(c: AbstractCard) -> void:
	var idx: int = card_queue.find_custom(func(v): return v.card == c)
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
