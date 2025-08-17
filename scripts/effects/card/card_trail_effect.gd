class_name CardTrailEffect
extends AbstractGameEffect

const SCALE_MULTI = 22.0

var trail_sprite: Sprite2D = null

func _ready() -> void:
    can_recycle = true

func reset(pos: Vector2) -> void:
    duration = 0.5
    starting_duration = duration
    position = pos
    modulate = CardGame.dungeon_main_screen.player.get_card_trail_color()
    scale = Vector2.ONE * 0.01
    is_done = false


func _process(delta: float) -> void:
    duration -= delta
    if duration < 0.25:
        scale = Vector2.ONE * duration * SCALE_MULTI
    else:
        scale = Vector2.ONE * (duration - 0.25) * SCALE_MULTI
    
    if duration <= 0:
        is_done = true
        Soul.recycle_trail_effect(self)
    else:
        modulate.a = CardGame.interpolation.apply_fade(0, 0.18, duration / starting_duration)
