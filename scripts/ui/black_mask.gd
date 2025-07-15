class_name BlackMask
extends TextureRect
var is_fading: bool = false
var is_black: bool = false


func _ready() -> void:
	texture = CanvasTexture.new()
	self.modulate = Color(0, 0, 0, 0)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	set_anchors_preset(PRESET_FULL_RECT)
	z_index = Global.BLACKMASK_Z_INDEX
	

func fade_in(fade_in_finished: Callable, instant: bool = false) -> void:
	if instant:
		modulate =  Color.BLACK
		if fade_in_finished.is_valid():
			fade_in_finished.call()
		fading_in_callback()
	else:
		var fade_in_tween = get_tree().create_tween()
		fade_in_tween.tween_property(self, "modulate", Color.BLACK, 1.0)
		fade_in_tween.tween_callback(fading_in_callback)
		fade_in_tween.tween_callback(fade_in_finished)
		is_fading = true

func fading_in_callback() -> void:
	# print("fading_in_callback")
	is_fading = false
	is_black = true

func fade_out(fade_out_finished: Callable = Callable(), instant: bool = false) -> void:
	if instant:
		modulate = Color(0, 0, 0, 0)
		if fade_out_finished.is_valid():
			fade_out_finished.call()
		fading_out_callback()
	else:
		var fade_in_tween = get_tree().create_tween()
		fade_in_tween.tween_property(self, "modulate", Color(0, 0, 0, 0), 1.0)
		fade_in_tween.tween_callback(fading_out_callback)
		fade_in_tween.tween_callback(fade_out_finished)
		is_fading = true

func fading_out_callback() -> void:
	# print("fading_out_callback")
	is_fading = false
	is_black = false