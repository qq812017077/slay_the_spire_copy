class_name FloatyEffect
extends Object

var offset: Vector2
var speed: Vector2

var scale: float = 1.0
var speed_scale: float = 1.0
var min_v: float = 0.0
var max_v: float = 0.0

var threshold: float = 0.0
func _init(dist_scale: float, _speed_scale: float) -> void:
    scale = dist_scale
    speed_scale = _speed_scale
    min_v = 0.4 * scale
    max_v = 3.0 * scale
    threshold = 0.95 * scale

    speed = Vector2(randf_range(-max_v, max_v), randf_range(-max_v, max_v)) * speed_scale

func update(delta: float) -> void:
    offset += speed * delta
    if offset.y > threshold:
        speed.y -= randf_range(min_v, max_v) * speed_scale
    elif offset.y < -threshold:
        speed.y += randf_range(min_v, max_v) * speed_scale
    
    if offset.x > threshold:
        speed.x -= randf_range(min_v, max_v) * speed_scale
    elif offset.x < -threshold:
        speed.x += randf_range(min_v, max_v) * speed_scale