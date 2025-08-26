class_name TriggerEndOfTurnOrbsAction
extends AbstractGameAction

func tick(_delta: float) -> void:

    if not CardGame.dungeon_main_screen.player.orbs.is_empty():
        for orb in CardGame.dungeon_main_screen.player.orbs:
            orb.on_end_of_turn()
    is_done = true