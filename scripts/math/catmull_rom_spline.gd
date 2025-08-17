class_name CatmullRomSpline
extends Object


var control_points: Array[Vector2]
var segment_lengths: Array[float]
var total_length: float = 0.0
var closed: bool = false
var _alpha: float = 0.5
var _tension: float = 0.0

var seg_idx: int = 0
var seg_t: float = 0.0
func _init(points: Array = [], close_curve: bool = false):
	load_points(points, close_curve)
	_alpha = 0.5
	_tension = 0.0


func load_points(points: Array, close_curve: bool = false):
	control_points.assign(points)
	closed = close_curve
	segment_lengths = []
	total_length = 0.0

	for i in range(1, control_points.size()):
		var length = control_points[i].distance_to(control_points[i - 1])
		segment_lengths.append(length)
		total_length += length
	
	if closed:
		var length = control_points[0].distance_to(control_points[control_points.size() - 1])
		segment_lengths.append(length)
		total_length += length
	
	# print("total_length: {0}".format([total_length]))

func search_segment(t: float) -> void:
	var accum_len: float = 0.0
	var target_len = t * total_length
	seg_idx = 0
	seg_t = 0.0
	for i in range(0, segment_lengths.size()):
		if target_len <= accum_len + segment_lengths[i]:
			seg_idx = i
			seg_t = clamp((target_len - accum_len) / segment_lengths[i], 0.0, 1.0)
			return
		accum_len += segment_lengths[i]
			
func value_at(t: float) -> Vector2:
	var n := control_points.size()
	var effective_t := t
	
	if closed:
		effective_t = fmod(t, 1.0)
		if effective_t < 0:
			effective_t += 1.0
	else:
		effective_t = clamp(t, 0.0, 1.0)
	
	search_segment(t)
	var i: int = seg_idx
	var local_t: float = seg_t
	var p0: Vector2 = control_points[max(i - 1, 0)]
	var p1: Vector2 = control_points[i]
	var p2: Vector2 = control_points[i + 1]
	var p3: Vector2 = control_points[min(i + 2, n-1)]
	
	return _catmull_rom_v2(p0, p1, p2, p3, local_t, _alpha)
	

static func _catmull_rom(p0: Vector2, p1: Vector2, p2: Vector2, p3: Vector2, t: float, alpha: float = 0.5, tension: float = 0.0) -> Vector2:
	var t01: float = pow(p0.distance_to(p1), alpha)
	var t12: float = pow(p1.distance_to(p2), alpha)
	var t23: float = pow(p2.distance_to(p3), alpha)

	var m1: Vector2 = (1 - tension) * (p2 - p1 + t12 * ((p1 - p0) / t01 - (p2 - p0) / (t01 + t12)))
	var m2: Vector2 = (1 - tension) * (p2 - p1 + t12 * ((p3 - p2) / t23 - (p3 - p1) / (t12 + t23)))

	var a: Vector2 = 2.0 * (p1 - p2) + m1 + m2
	var b: Vector2 = -3.0 * (p1 - p2) - 2.0 * m1 - m2
	var c: Vector2 = m1
	var d: Vector2 = p1

	return a * t * t * t + b * t * t + c * t + d


static func _catmull_rom_v2(p0: Vector2, p1: Vector2, p2: Vector2, p3: Vector2, t: float, alpha: float = 0.5) -> Vector2:
	var t2 = t * t
	var t3 = t2 * t
	return alpha * (
		(2 * p1) +
		(-p0 + p2) * t +
		(2 * p0 - 5 * p1 + 4 * p2 - p3) * t2 +
		(-p0 + 3 * p1 - 3 * p2 + p3) * t3
	)
