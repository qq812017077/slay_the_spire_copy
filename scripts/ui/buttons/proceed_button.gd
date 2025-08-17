class_name ProceedButton
extends ScreenButton


static var ui_string: UIString = null
static var TEXT: Array = []


func _ready() -> void:
	if ui_string == null:
		ui_string = CardGame.languagePack.get_ui_string("Proceed Button")
		TEXT = ui_string.TEXT
	
	ThemeHelper.clean_button_style(button)
	ThemeHelper.apply_button_font_style_with_color(button, {"font_color": Color.hex(0xffeda7ff)})
	starting_pos = position
	
	hide_button(true)
	button.pressed.connect(_on_button_click)