class_name EndTurnGlowEffect
extends AbstractGameEffect


@export var glow_sprite: Sprite2D

func _ready():
    duration = 2.0
    starting_duration = duration
    color =Color.WHITE
    glow_sprite.material = MaterialLibrary.add_material

func _process(delta: float):
    duration -= delta
    glow_sprite.scale = CardGame.interpolation.apply_fade(1.0, 2.0, 1.0 - duration / starting_duration) * Vector2.ONE
    glow_sprite.modulate.a = CardGame.interpolation.apply_fade(0.2, 0.0, 1.0 - duration / starting_duration)

    if duration <= 0:
        is_done = true



