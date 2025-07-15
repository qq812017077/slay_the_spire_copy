class_name Interpolation
extends Resource

@export var fade: Curve

func apply_fade(start: float, end: float, weight: float) -> float:
    return MathHelper.lerp_snap(start, end, fade.sample(weight))

func _apply_exp(start: float, end: float, weight: float, exp_num: int = 1) -> float:
    if weight < 0.5:
        return MathHelper.lerp_snap(start, end, 0.5 * pow(weight * 2, exp_num))
    return MathHelper.lerp_snap(start, end, 1 - 0.5 * pow((1 - weight) * 2, exp_num))

func apply_exp10(start: float, end: float, weight: float) -> float:
    return _apply_exp(start, end, weight, 10)


func _apply_powin(start: float, end: float, weight: float, pow_num: int = 1) -> float:
    return MathHelper.lerp_snap(start, end, pow(weight, pow_num))

func _apply_powout(start: float, end: float, weight: float, pow_num: int = 1) -> float:
    return MathHelper.lerp_snap(start, end, 1 - pow(1 - weight, pow_num))

func apply_pow5out(start: float, end: float, weight: float) -> float:
    return _apply_powout(start, end, weight, 5)