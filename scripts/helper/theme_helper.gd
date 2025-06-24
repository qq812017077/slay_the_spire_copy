class_name ThemeHelper
extends Object

static var theme : Theme = null

# font
static var normal_font_eng: Font = null
static var bold_font_eng: Font = null
static var italic_font_eng: Font = null

static var normal_font_zhs: Font = null
static var bold_font_zhs: Font = null
static var italic_font_zhs: Font = null


# desc 
static var card_desc_font_size: int = 16
static var card_desc_line_height_scale: float = 0.8
# desc color
static var card_desc_normal_color: Color = Color(1, 1, 1, 1)
static var card_desc_keyword_color: Color = Color(1, 1, 1, 1)
static var card_desc_shadow_color: Color = Color(0, 0, 0, 0)
static var card_desc_shadow_offset: Vector2 = Vector2(0, 0)

# tab color
static var tab_font_size: int = 28
static var tab_font_normal_color: Color
static var tab_font_selected_color: Color

# top panel info 
static var top_panel_info_font_size: int = 28
static var top_panel_info_outline_size: int
static var top_panel_info_shadow_offset_x: int
static var top_panel_info_shadow_offset_y: int
static var top_panel_font_normal_color: Color 
static var top_panel_font_pressed_color: Color 
static var top_panel_font_shadow_color: Color 
static var top_panel_font_outline_color: Color 
static func initialize():
	# font load
	normal_font_eng = load("res://arts/slay_the_spire/fonts/Kreon-Regular.ttf")
	bold_font_eng = load("res://arts/slay_the_spire/fonts/Kreon-Bold.ttf")
	italic_font_eng = load("res://arts/slay_the_spire/fonts/ZillaSlab-RegularItalic.otf")

	normal_font_zhs = load("res://arts/slay_the_spire/fonts/zhs/NotoSansMonoCJKsc-Regular.otf")
	bold_font_zhs = load("res://arts/slay_the_spire/fonts/zhs/SourceHanSerifSC-Bold.otf")
	italic_font_zhs = load("res://arts/slay_the_spire/fonts/zhs/SourceHanSerifSC-Medium.otf")


	theme = load("res://arts/themes/card_theme.tres")
	if theme == null:
		push_error("Failed to load theme from 'res://arts/themes/card_theme.tres'")
		return
	
	# desc
	card_desc_normal_color = theme.get_color("normal_color", "CardDescriptionLabel")
	card_desc_keyword_color = theme.get_color("keyword_color", "CardDescriptionLabel")
	# desc shadow
	card_desc_shadow_color = theme.get_color("shadow_color", "CardDescriptionLabel")
	card_desc_shadow_offset.x = theme.get_constant("shadow_offset_x", "CardDescriptionLabel")
	card_desc_shadow_offset.y = theme.get_constant("shadow_offset_y", "CardDescriptionLabel")

	# tab color
	tab_font_normal_color = theme.get_color("tab_font_normal_color", "CardLibraryScreen")
	tab_font_selected_color = theme.get_color("tab_font_selected_color", "CardLibraryScreen")

	# top panel
	top_panel_font_normal_color = theme.get_color("font_normal_color", "SortHeader")
	top_panel_font_pressed_color = theme.get_color("font_pressed_color", "SortHeader")
	top_panel_font_shadow_color = theme.get_color("font_shadow_color", "SortHeader")
	top_panel_font_outline_color = theme.get_color("font_outline_color", "SortHeader")
	top_panel_info_font_size = theme.get_constant("font_size", "SortHeader")
	top_panel_info_outline_size = theme.get_constant("outline_size", "SortHeader")
	top_panel_info_shadow_offset_x = theme.get_constant("shadow_offset_x", "SortHeader")
	top_panel_info_shadow_offset_y = theme.get_constant("shadow_offset_y", "SortHeader")
static func get_desc_string_size(line_str: String) -> Vector2:
	return normal_font_eng.get_string_size(line_str, HorizontalAlignment.HORIZONTAL_ALIGNMENT_LEFT, -1, card_desc_font_size)
	
static func get_desc_string_size_cn(line_str: String) -> Vector2:
	return normal_font_zhs.get_string_size(line_str, HorizontalAlignment.HORIZONTAL_ALIGNMENT_LEFT, -1, card_desc_font_size)


static func get_tab_label_font() -> Font:
	if Settings.language ==Settings.GameLanguage.ENG:
		return normal_font_eng
	
	if Settings.language ==Settings.GameLanguage.ZHS:
		return normal_font_zhs
	
	return normal_font_eng

static func get_top_panel_info_font() -> Font:
	if Settings.language ==Settings.GameLanguage.ENG:
		return bold_font_eng
	
	if Settings.language ==Settings.GameLanguage.ZHS:
		return bold_font_zhs
	
	return bold_font_eng

static func get_card_title_font() -> Font:
	if Settings.language ==Settings.GameLanguage.ENG:
		return normal_font_eng
	
	if Settings.language ==Settings.GameLanguage.ZHS:
		return normal_font_zhs
	
	return normal_font_eng

static func get_card_type_font() -> Font:
	if Settings.language ==Settings.GameLanguage.ENG:
		return bold_font_eng
	
	if Settings.language ==Settings.GameLanguage.ZHS:
		return bold_font_zhs
	
	return bold_font_eng

static func apply_top_panel_font_style(control: Control) -> void:
	var top_panel_info_font: Font = null
	match Settings.language:
		Settings.GameLanguage.ENG:
			top_panel_info_font = bold_font_eng
		Settings.GameLanguage.ZHS:
			top_panel_info_font = bold_font_zhs
	control.add_theme_font_override("font", top_panel_info_font)
	control.add_theme_font_size_override("font_size", top_panel_info_font_size)
	
	control.add_theme_color_override("icon_color", top_panel_font_normal_color)
	control.add_theme_color_override("font_color", top_panel_font_normal_color)
	# control.add_theme_color_override("font_pressed_color", top_panel_font_pressed_color)
	# control.add_theme_color_override("font_hover_color", top_panel_font_pressed_color)
	# control.add_theme_color_override("font_hover_pressed_color", top_panel_font_pressed_color)
	control.add_theme_color_override("font_shadow_color", top_panel_font_shadow_color)
	control.add_theme_color_override("font_outline_color", top_panel_font_outline_color)

	control.add_theme_constant_override("shadow_offset_x", top_panel_info_shadow_offset_x)
	control.add_theme_constant_override("shadow_offset_y", top_panel_info_shadow_offset_y)
	control.add_theme_constant_override("outline_size", top_panel_info_outline_size)