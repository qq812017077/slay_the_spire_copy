class_name ChestShineEffect
extends AbstractParticleEffect

var close_wait_timer: float = 2.0

func _process(delta: float) -> void:
    if not is_done and not is_playing:
        close_wait_timer -= delta
        if close_wait_timer <= 0:
            is_done = true
    elif is_playing:
        close_wait_timer = 2.0
