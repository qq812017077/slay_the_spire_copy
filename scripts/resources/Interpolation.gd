class_name Interpolation
extends Resource

@export var fade: Curve


func apply_fade(start:float, end:float, weight:float) -> float:
    return MathHelper.lerp_snap(start, end, fade.sample(weight))