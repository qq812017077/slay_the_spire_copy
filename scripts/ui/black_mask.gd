class_name BlackMask
extends TextureRect

const EMPTYCALLBACK = Callable()
enum FadeState {IDLE, FADING_IN, BLACK, FADING_OUT}
# var is_fading: bool = false
var state: FadeState = FadeState.IDLE


func _ready() -> void:
	texture = CanvasTexture.new()
	self.modulate = Color(0, 0, 0, 0)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	set_anchors_preset(PRESET_FULL_RECT)
	z_index = Global.BLACKMASK_Z_INDEX

func fade_in_instant() -> void:
	modulate = Color.BLACK
	fading_in_callback()

func fade_out_instant() -> void:
	modulate = Color(0, 0, 0, 0)
	fading_out_callback()

func is_idle() -> bool:
	return state == FadeState.IDLE

func is_fading() -> bool:
	return state == FadeState.FADING_IN or state == FadeState.FADING_OUT

func is_black() -> bool:
	return state == FadeState.BLACK

func fade_in(duration: float = 1.0, fade_in_finished: Callable = EMPTYCALLBACK) -> void:
	var fade_in_tween = get_tree().create_tween()
	fade_in_tween.tween_property(self, "modulate", Color.BLACK, duration)
	fade_in_tween.tween_callback(fading_in_callback)
	if fade_in_finished.is_valid():
		fade_in_tween.tween_callback(fade_in_finished)
	state = FadeState.FADING_IN

func fading_in_callback() -> void:
	# print("fading_in_callback")
	state = FadeState.BLACK

func fade_out(duration: float = 1.0, fade_out_finished: Callable = EMPTYCALLBACK) -> void:
	var fade_out_tween = get_tree().create_tween()
	fade_out_tween.tween_property(self, "modulate", Color(0, 0, 0, 0), duration)
	fade_out_tween.tween_callback(fading_out_callback)
	if fade_out_finished.is_valid():
		fade_out_tween.tween_callback(fade_out_finished)
	state = FadeState.FADING_OUT

func fading_out_callback() -> void:
	state = FadeState.IDLE