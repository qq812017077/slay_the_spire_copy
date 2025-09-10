class_name DrawCardAction
extends AbstractGameAction

static var drawn_cards: Array[AbstractCard] = []


var shuffle_check: bool = false
var clear_draw_history: bool = true
var follow_up_action: AbstractGameAction = null


func _init(_source: AbstractCreature, _amount: int, is_end_turn_draw: bool = false, action: AbstractGameAction = null, _clear_draw_history: bool = true) -> void:
    set_values_with_amount(CardGame.dungeon_main_screen.player, source, _amount)
    action_type = ActionType.DRAW
    if Settings.FAST_MODE:
        duration = Settings.ACTION_DUR_XFAST
    else:
        duration = Settings.ACTION_DUR_FASTER
    
    if is_end_turn_draw:
        # CardGame.dungeon_main_screen.add_game_effect(PlayerTurnEffect.new())
        pass
    
    follow_up_action = action
    clear_draw_history = _clear_draw_history
    
func _process(delta: float) -> void:
    if clear_draw_history:
        drawn_cards.clear()
        clear_draw_history = false

    
    if amount < 0:
        end_action_with_follow_up()
        return 

    # var deck_amount = 

func end_action_with_follow_up():
    is_done = true
    if follow_up_action:
        add_to_top(follow_up_action)