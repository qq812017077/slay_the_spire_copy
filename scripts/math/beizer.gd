class_name Beizer
extends Object


static func quadratic(p0: Vector2, p1: Vector2, p2: Vector2, t: float) -> Vector2:
	# p0 - The first bezier point.
	# p1 - The second bezier point.
	# p2 - The third bezier point.
	# t - The time parameter, ranging from 0.0 to 1.0.

	# 二次贝塞尔曲线公式: B(t) = (1-t)²P0 + 2(1-t)tP1 + t²P2
	var mt = 1.0 - t  # (1-t)
	var mt2 = mt * mt  # (1-t)²
	var t2 = t * t	 # t²
	var two_mt_t = 2 * mt * t  # 2(1-t)t
	
	var out: Vector2 = Vector2.ZERO
	# 计算曲线上的点
	out.x = mt2 * p0.x + two_mt_t * p1.x + t2 * p2.x
	out.y = mt2 * p0.y + two_mt_t * p1.y + t2 * p2.y
	return out