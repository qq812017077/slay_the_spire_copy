class_name CharacterInfoContainer
extends Control

@export var character_name: Label = null
@export var hp_icon: Sprite2D = null
@export var hp_info: Label = null
@export var coin_icon: Sprite2D = null
@export var coin_info: Label = null
@export var description: SmartLabel = null
@export var relic_outlint_icon: Sprite2D = null
@export var relic_icon: Sprite2D = null
@export var relic_name: Label = null
@export var relic_description: SmartLabel = null

func apply_style() -> void:
	ThemeHelper.apply_banner_name_font(character_name)
	ThemeHelper.apply_tip_header_font(hp_info, {
		"font_color": ThemeHelper.RED_TEXT_COLOR
	})
	ThemeHelper.apply_tip_header_font(coin_info, {
		"font_color": ThemeHelper.GOLD_COLOR
	})

	description.label_setting = LabelSettings.new()
	description.label_setting.font = ThemeHelper.get_bold_font()
	description.label_setting.font_size = 22
	description.label_setting.font_color = Color.hex(0xfff6e2ff)
	description.label_setting.outline_color = Color.DARK_GRAY
	description.label_setting.outline_size = 3
	description.label_setting.shadow_color = ThemeHelper.QUARTER_TRANSPARENT_BLACK_COLOR
	description.label_setting.shadow_offset = Vector2(2, 2)

	ThemeHelper.apply_label_font_style_with(relic_name, {
		"font_color": ThemeHelper.GOLD_COLOR,
		"font_size": 22,
		"font_outline_color": Color(0.3, 0.3, 0.3, 1),
		"outline_size": 2,
		"font_shadow_color": ThemeHelper.QUARTER_TRANSPARENT_BLACK_COLOR,
		"shadow_offset_x": 2,
		"shadow_offset_y": 2,
		})

	relic_description.label_setting = LabelSettings.new()
	relic_description.label_setting.font = ThemeHelper.get_bold_font()
	relic_description.label_setting.font_size = 22
	relic_description.label_setting.font_color = ThemeHelper.CREAM_COLOR
	relic_description.label_setting.outline_color = Color(0.3, 0.3, 0.3, 1)
	relic_description.label_setting.outline_size = 2
	relic_description.label_setting.shadow_color = ThemeHelper.QUARTER_TRANSPARENT_BLACK_COLOR
	relic_description.label_setting.shadow_offset = Vector2(2, 2)


	hp_icon.texture = ImageMaster.TP_HP
	coin_icon.texture = ImageMaster.TP_GOLD