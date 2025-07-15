class_name MapDot
extends Object

const DIST_JITTER: float = 4
var position: Vector2
var rotation: float = 0


func _init(_pos: Vector2, _rot: float, jitter: bool = false) -> void:
	position = _pos
	rotation = _rot
	if jitter:
		position += Vector2(randf_range(-DIST_JITTER, DIST_JITTER), randf_range(-DIST_JITTER, DIST_JITTER))
		rotation += randf_range(-20, 20)