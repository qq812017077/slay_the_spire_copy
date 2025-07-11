class_name TopPanelToggleButton
extends Button


func _ready() -> void:
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)


func _on_mouse_entered() ->void:
	CardGame.sound.single_play("UI_HOVER", -0.3)
	if button_pressed:
		return 
	self_modulate = ThemeHelper.top_panel_font_pressed_color

func _on_mouse_exited() -> void:
	if button_pressed:
		return 
	self_modulate = Color.WHITE
