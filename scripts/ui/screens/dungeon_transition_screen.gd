# 进入每一层开始时的关卡信息提示
class_name DungeonTransitionScreen
extends Control

static var ui_string: UIString = null
static var TEXT: Array

static func initialize() -> void:
	ui_string = CardGame.languagePack.get_ui_string("DungeonTransitionScreen")
	TEXT = ui_string.TEXT

@export var level_num: Label
@export var level_name: Label

var duration: float = 0
var starting_duration: float = 0.0
var alpha: float = 0
var is_done: bool = true
func _ready() -> void:

	ThemeHelper.apply_label_font_style_with(level_num, {
		"font": ThemeHelper.get_regular_font(),
		"font_size": 48,
		"font_color": ThemeHelper.BLUE_TEXT_COLOR,
		"font_outline_color": Color(0.35, 0.35, 0.35, 1),
		"outline_size": 8,
		"font_shadow_color": ThemeHelper.QUARTER_TRANSPARENT_BLACK_COLOR,
		"shadow_offset_x": 3,
		"shadow_offset_y": 3,
		})
	ThemeHelper.apply_label_font_style_with(level_name, {
		"font": ThemeHelper.get_bold_font(),
		"font_size": 115,
		"font_color": ThemeHelper.GOLD_COLOR,
		"font_outline_color": Color(0.0, 0.0, 0.0, 0.33),
		"outline_size": 32,
		"font_shadow_color": ThemeHelper.QUARTER_TRANSPARENT_BLACK_COLOR,
		"shadow_offset_x": 0,
		"shadow_offset_y": 0,
		})

	
	# open(Exordium.ID)

func _process(delta: float) -> void:
	if is_done:
		return
	duration -= delta
	if duration > 4.0:
		alpha = CardGame.interpolation.apply_pow5out(1.0, 0.0, (duration - 4.0) / 4.0)
	else:
		alpha = CardGame.interpolation.apply_fade(0, 1, duration / 2.5)
	
	if duration < 0:
		is_done = true
		visible = false
	level_num.self_modulate.a = alpha
	level_name.self_modulate.a = alpha

func open(key: String):
	visible = true
	set_area_name(key)
	duration = 5.0
	starting_duration = duration
	is_done = false

func set_area_name(key: String):
	match key:
		Exordium.ID:
			level_num.text = TEXT[2]
			level_name.text = TEXT[3]
		TheCity.ID:
			level_num.text = TEXT[4]
			level_name.text = TEXT[5]
		TheBeyond.ID:
			level_num.text = TEXT[6]
			level_name.text = TEXT[7]
		TheEnding.ID:
			level_num.text = TEXT[8]
			level_name.text = TEXT[9]
		_:
			level_num.text = TEXT[8]
			level_name.text = TEXT[9]
	# print("level num", level_num.text)
	# print("level name", level_name.text)
