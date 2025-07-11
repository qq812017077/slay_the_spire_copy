class_name TextDrawCommand
extends DrawCommand

var text: String = ""
var draw_shadow: bool = false
var draw_outline: bool = false
var label_setting: LabelSettings = null
var custom_color: Dictionary = {}

var draw_shadow_color : Color 
var draw_outline_color : Color 
var draw_font_color : Color 
func _init(_text: String, _label_setting: LabelSettings, _draw_shadow: bool = false, _draw_outline: bool = false, _custom_color: Dictionary = {}) -> void:
	super (DrawType.TEXT)
	text = _text
	draw_shadow = _draw_shadow
	draw_outline = _draw_outline
	label_setting = _label_setting
	custom_color = _custom_color
	size = label_setting.font.get_string_size(text, HorizontalAlignment.HORIZONTAL_ALIGNMENT_LEFT, -1, label_setting.font_size)
	token_text.add_string(text, _label_setting.font, _label_setting.font_size)

	draw_shadow_color = custom_color.get("shadow_color", label_setting.shadow_color)
	draw_outline_color = custom_color.get("outline_color", label_setting.outline_color)
	draw_font_color = custom_color.get("font_color", label_setting.font_color)

func draw_command(_canvas: CanvasItem, _location: Vector2) -> void:
	token_text.width = token_text.get_line_width() if size.x <= 0 else size.x
	if draw_shadow:
		token_text.draw(_canvas.get_canvas_item(), _location + label_setting.shadow_offset, draw_shadow_color, 2.0)
	if draw_outline and label_setting.outline_size > 0:
		token_text.draw_outline(_canvas.get_canvas_item(), _location, label_setting.outline_size, draw_outline_color, 2.0)
	token_text.draw(_canvas.get_canvas_item(), _location, draw_font_color, 2.0)
