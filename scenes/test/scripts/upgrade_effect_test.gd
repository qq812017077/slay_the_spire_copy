extends Control

func _ready() -> void:
    await get_tree().create_timer(1.0).timeout

    var effect = UpgradeShineEffect.new(Vector2(Settings.DEFAULT_WIDTH / 2.0, Settings.DEFAULT_HEIGHT / 2.0))
    CardGame.dungeon_main_screen.add_game_effect(effect)