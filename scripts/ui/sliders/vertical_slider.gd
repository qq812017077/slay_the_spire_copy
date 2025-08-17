class_name VerticalSlider
extends VSlider


var grabber_height: float = 0
var target_slider_percent: float = 1
func _ready() -> void:
	gui_input.connect(_on_slider_gui_input)
	var grabber = get_theme_icon("grabber", "VSlider")
	if grabber != null:
		grabber_height = grabber.get_height()
	allow_greater = true
	allow_lesser = true

func _process(delta: float) -> void:
	if target_slider_percent > 1.0:
		target_slider_percent = MathHelper.lerp_snap(target_slider_percent, 1.0, delta * 12)
	if target_slider_percent < 0.0:
		target_slider_percent = MathHelper.lerp_snap(target_slider_percent, 0.0, delta * 12)
	var target_value = (max_value - min_value) * target_slider_percent
	value = MathHelper.lerp_snap(value, target_value, delta * 12)


func set_slider_percent(percent: float) -> void:
	target_slider_percent = percent
	value = (max_value - min_value) * target_slider_percent


func _on_slider_gui_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		var input_event = event as InputEventMouse
		if input_event.button_mask == MOUSE_BUTTON_LEFT:
			# print("position:", input_event.position)
			var percent = clamp((input_event.position.y - grabber_height * 0.5) / (size.y - grabber_height), 0.0, 1.0)
			target_slider_percent = 1 - percent
