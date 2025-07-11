class_name BlackMask
extends TextureRect
var is_black: bool = false

signal fading_out

func _ready() -> void:
	texture = CanvasTexture.new()
	self.modulate = Color(0, 0, 0, 0)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	set_anchors_preset(PRESET_FULL_RECT)
	z_index = Global.BLACKMASK_Z_INDEX
	

func fade_in(fade_in_finished: Callable, instant: bool = false) -> void:
	if instant:
		self_modulate = Color.TRANSPARENT
		if fade_in_finished.is_valid():
			fade_in_finished.call()
	else:
		var fade_in_tween = get_tree().create_tween()
		fade_in_tween.tween_property(self, "modulate", Color.BLACK, 1.0)
		fade_in_tween.tween_callback(fade_in_finished)


func fade_out(fade_out_finished: Callable = Callable(), instant: bool = false) -> void:
	if instant:
		self_modulate = Color.TRANSPARENT
		if fade_out_finished.is_valid():
			fade_out_finished.call()
	else:
		var fade_in_tween = get_tree().create_tween()
		fade_in_tween.tween_property(self, "modulate", Color(0, 0, 0, 0), 1.0)
		fade_in_tween.tween_callback(fade_out_finished)

		fade_in_tween.tween_callback(fading_out_callback)

func fading_out_callback() -> void:
	fading_out.emit()
	visible = false