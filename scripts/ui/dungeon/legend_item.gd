class_name LegendItem
extends Control


@export var legend_icon: TextureRect
@export var legend_name: Label


var tip_header: String
var tip_body: String
var index: int

var type = AbstractRoom.RoomType.MONSTER
var _is_hover: bool = false

func _ready() -> void:
	ThemeHelper.apply_label_font_style_with(legend_name, {
		"font": ThemeHelper.get_regular_font(),
		"font_size": 30,
		"font_color": ThemeHelper.AVAILABLE_COLOR,
		"font_outline_color": Color(0.35, 0.35, 0.35, 1),
		"outline_size": 0,
		"font_shadow_color": Color(0.0, 0.0, 0.0, 0.11),
		"shadow_offset_x": 3,
		"shadow_offset_y": 3,
		})
	legend_icon.modulate = ThemeHelper.AVAILABLE_COLOR

	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


func is_hover() -> bool:
	return _is_hover

func _on_mouse_entered() -> void:
	_is_hover = true
	legend_icon.scale = Vector2(1.3, 1.3)

func _on_mouse_exited() -> void:
	_is_hover = false
	legend_icon.scale = Vector2.ONE