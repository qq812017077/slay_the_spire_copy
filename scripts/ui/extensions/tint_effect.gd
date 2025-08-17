class_name TintEffect
extends Object

var target_color: Color = Color(1, 1, 1, 0)
var color: Color = Color(1, 1, 1, 0)
var lerp_speed: float = 3

func set_target_color(_color: Color, _lerp_speed: float = 3) -> void:
    target_color = _color
    self.lerp_speed = _lerp_speed

func fade_out() -> void:
    set_target_color(Color(color.r, color.g, color.b, 0))

func update(delta: float) -> void:
    color = color.lerp(target_color, delta * lerp_speed)