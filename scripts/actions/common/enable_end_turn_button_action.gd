class_name EnableEndTurnButtonAction
extends AbstractGameAction

func update(_delta: float) -> void:
    if CardGame.dungeon_main_screen:
        CardGame.dungeon_main_screen.dungeon_room_screen.combat_ui.end_turn_button.enable()
    else:
        push_error("DungeonMainScreen not found in EnableEndTurnButtonAction")
    is_done = true