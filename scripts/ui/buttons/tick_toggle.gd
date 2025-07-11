class_name TickToggle
extends Control

@export var checked: bool = false
@export var tick_icon: Sprite2D
@export var button: Button
@export var normal_color: Color = Color.WHITE
@export var hover_color: Color = Color.MINT_CREAM

func _ready() -> void:
	if button != null:
		ThemeHelper.clean_button_style(button)
		button.toggle_mode = true
		button.add_theme_color_override("font_color", normal_color)
		button.add_theme_color_override("font_focus_color", normal_color)
		button.add_theme_color_override("font_pressed_color", normal_color)
		button.add_theme_color_override("font_hover_color", hover_color)
		button.add_theme_color_override("font_hover_pressed_color", hover_color)

		button.toggled.connect(_on_toggled_changed)

		button.button_pressed = checked
		tick_icon.visible = checked


	
func _on_toggled_changed(toggled: bool) -> void:
	checked = toggled
	tick_icon.visible = toggled

func set_text(text: String) -> void:
	button.text = "     " + text

func set_normal_color(_normal_color) -> void:
	normal_color = _normal_color
	button.add_theme_color_override("font_color", normal_color)
	button.add_theme_color_override("font_focus_color", normal_color)

func set_hover_color(_hover_color) -> void:
	hover_color = _hover_color
	button.add_theme_color_override("font_pressed_color", hover_color)
	button.add_theme_color_override("font_hover_color", hover_color)
	button.add_theme_color_override("font_hover_pressed_color", hover_color)

func set_toggle_style(dict: Dictionary = {}) -> void:
	var card_title_setting : LabelSettings = ThemeHelper.card_title_label_setting
	button.add_theme_font_override("font", dict.get("font", card_title_setting.font))
	button.add_theme_font_size_override("font_size", dict.get("font_size", card_title_setting.font_size))
	button.add_theme_color_override("font_outline_color", dict.get("outline_color", card_title_setting.outline_color))
	button.add_theme_constant_override("outline_size", dict.get("font_outline_size", card_title_setting.outline_size))