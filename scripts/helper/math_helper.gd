class_name MathHelper


static func swing_in(start: float, end: float, t: float) -> float:
	t = clampf(t, 0.0, 1.0)
	var result = start + (end - start) * pow(t, 4)

	return result

static func pow4_in(start: float, end: float, t: float) -> float:
	t = clampf(t, 0.0, 1.0)
	var result = start + (end - start) * pow(t, 4)

	return result

static func lerp_snap(start: float, target: float, weight: float) -> float:
	if start != target:
		var ascending: bool = start < target
		start = lerp(start, target, weight)
		if ascending:
			if start >= target:
				start = target
		else:
			if start <= target:
				start = target
	return start

static func vec2_lerp_snap(start: Vector2, target: Vector2, weight: float) -> Vector2:
	if start != target:
		var ascending: bool = start < target
		start = lerp(start, target, weight)
		if ascending:
			if start >= target:
				start = target
		else:
			if start <= target:
				start = target
	
	return start
