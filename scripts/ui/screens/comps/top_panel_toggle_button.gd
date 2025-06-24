class_name TopPanelToggleButton
extends Button


func _ready() -> void:
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	connect("toggled", _on_toggled)


func _on_toggled(toggle_on: bool) ->void:
	if icon == null:
		return 
	var img : Image = icon.get_image()
	img.flip_y()
	icon = ImageTexture.create_from_image(img)
	# self_modulate = ThemeHelper.top_panel_font_pressed_color if toggle_on else Color.WHITE
	

func _on_mouse_entered() ->void:
	if button_pressed:
		return 
	self_modulate = ThemeHelper.top_panel_font_pressed_color

func _on_mouse_exited() -> void:
	if button_pressed:
		return 
	self_modulate = Color.WHITE
