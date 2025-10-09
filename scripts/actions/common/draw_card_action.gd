class_name DrawCardAction
extends AbstractGameAction

static var drawn_cards: Array[AbstractCard] = []


var shuffle_check: bool = false
var clear_draw_history: bool = true
var follow_up_action: AbstractGameAction = null


func _init(_source: AbstractCreature, _amount: int, is_end_turn_draw: bool = false, action: AbstractGameAction = null, _clear_draw_history: bool = true) -> void:
	set_values_with_amount(CardGame.dungeon_main_screen.player, source, _amount)
	action_type = ActionType.DRAW
	reset_duration()
	push_error("call draw action.")
	if is_end_turn_draw:
		# CardGame.dungeon_main_screen.add_game_effect(PlayerTurnEffect.new())
		pass
	
	follow_up_action = action
	clear_draw_history = _clear_draw_history
	
func update(delta: float) -> void:
	if clear_draw_history:
		drawn_cards.clear()
		clear_draw_history = false

	
	if amount < 0:
		end_action_with_follow_up()
		return 

	var deck_size :int = CardGame.dungeon_main_screen.player.draw_pile.size()
	var discard_size :int = CardGame.dungeon_main_screen.player.discard_pile.size()
	var hand_size :int = CardGame.dungeon_main_screen.player.hand.size()
	# print("deck_size: ", deck_size, " discard_size: ", discard_size, " hand_size: ", hand_size)
	if CardGame.soul.is_active():
		return
	
	if deck_size + discard_size == 0:
		print("no more cards to draw")
		end_action_with_follow_up()
		return 
	
	if hand_size == 10:
		print("hand is full")
		create_hand_is_full_dialog()
		end_action_with_follow_up()
		return 
	
	if not shuffle_check:
		if amount + hand_size > 10:
			# var hand_size_and_draw :int = 10 - amount + hand_size
			# amount = hand_size + 10
			create_hand_is_full_dialog()
		
		if amount > deck_size:
			var tmp: int = amount - deck_size
			add_to_top(DrawCardAction.new(null, tmp, false, follow_up_action, false))
			add_to_top(EmptyDeckShuffleAction.new())
			if deck_size != 0:
				add_to_top(DrawCardAction.new(null, deck_size, false, null, false))
				amount = 0
				is_done = true
			return
		
		shuffle_check = true
	
	duration -= delta
	
	if amount != 0 and duration < 0.0:
		reset_duration()
		amount-=1
		var end_action: bool = false
		if CardGame.dungeon_main_screen.player.draw_pile.size() != 0:
			var drawn_card : AbstractCard = CardGame.dungeon_main_screen.dungeon_room_screen.combat_ui.draw_card(true)
			drawn_cards.append(drawn_card)
		else:
			end_action = true
		
		end_action = amount == 0
		
		if end_action:
			end_action_with_follow_up()


func create_hand_is_full_dialog():
	CardGame.dungeon_main_screen.player.create_hand_is_full_dialog()
func end_action_with_follow_up():
	is_done = true
	if follow_up_action:
		add_to_top(follow_up_action)

func reset_duration() -> void:
	if Settings.FAST_MODE:
		duration = Settings.ACTION_DUR_XFAST
	else:
		duration = Settings.ACTION_DUR_FASTER
