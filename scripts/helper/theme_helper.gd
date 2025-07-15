class_name ThemeHelper
extends Object

static var theme: Theme = null

# stylebox
static var STYLE_BOX_EMPTY: StyleBox = StyleBoxEmpty.new()

# color
const HALF_TRANSPARENT_WHITE_COLOR = Color(1.0, 1.0, 1.0, 0.5);
const QUARTER_TRANSPARENT_WHITE_COLOR = Color(1.0, 1.0, 1.0, 0.25);
const TWO_THIRDS_TRANSPARENT_BLACK_COLOR = Color(0.0, 0.0, 0.0, 0.66);
const HALF_TRANSPARENT_BLACK_COLOR = Color(0.0, 0.0, 0.0, 0.5);
const QUARTER_TRANSPARENT_BLACK_COLOR = Color(0.0, 0.0, 0.0, 0.25);

static var GOLD_COLOR = Color.from_string("#EFC851FF", Color.GOLD)
static var CREAM_COLOR = Color.from_string("#fef5e1ff", Color.MINT_CREAM)
static var RED_TEXT_COLOR = Color.from_string("#ff6563ff", Color.RED)
static var GREEN_TEXT_COLOR = Color.from_string("#66ff66ff", Color.GREEN)
static var BLUE_TEXT_COLOR = Color.from_string("#4fc1ffff", Color.BLUE)
static var PURPLE_COLOR = Color.from_string("#ad37daff", Color.PURPLE)
static var AVAILABLE_COLOR = Color(0.09, 0.13, 0.17, 1.0)
# font
static var normal_font_eng: Font = null
static var bold_font_eng: Font = null
static var italic_font_eng: Font = null

static var normal_font_zhs: Font = null
static var bold_font_zhs: Font = null
static var italic_font_zhs: Font = null

# button
static var button_label_font_color: Color = Color.MINT_CREAM
static var button_label_font_size: int = 28
static var button_label_outline_size: int = 4
static var button_label_shadow_offset_x: int = 3
static var button_label_shadow_offset_y: int = 3

# label
static var label_font_size: int = 28
static var label_outline_size: int = 4
static var label_shadow_offset_x: int = 3
static var label_shadow_offset_y: int = 3
static var label_shadow_outline_size: int = 0

# top panel info 
static var top_panel_info_font_size: int = 28
static var top_panel_info_outline_size: int
static var top_panel_info_shadow_offset_x: int
static var top_panel_info_shadow_offset_y: int
static var top_panel_font_normal_color: Color
static var top_panel_font_pressed_color: Color
static var top_panel_font_shadow_color: Color
static var top_panel_font_outline_color: Color

# panel info
static var panel_info_font_size: int = 22
static var panel_info_outline_size: int
static var panel_info_shadow_offset_x: int
static var panel_info_shadow_offset_y: int

# card title
static var card_title_font_size: int = 32

# card tip

# card desc 
static var card_desc_font_size: int = 24
static var card_desc_line_height_scale: float = 0.8
static var large_card_desc_font_size: int = 48
static var card_desc_normal_color: Color = Color(1, 1, 1, 1)
static var card_desc_keyword_color: Color = Color(1, 1, 1, 1)
static var card_desc_shadow_color: Color = Color(0, 0, 0, 0)
static var card_desc_shadow_offset: Vector2 = Vector2(0, 0)
static var large_card_desc_shadow_offset: Vector2 = Vector2(0, 0)

# tab color
static var tab_font_size: int = 28
static var tab_font_normal_color: Color
static var tab_font_selected_color: Color

# damage number
static var damage_number_font_size: int = 40
static var damage_number_font_outline_size: int = 6
static var damage_number_font_shadow_offset_x: int = 4
static var damage_number_font_shadow_offset_y: int = 4

# character desc
static var character_desc_font_size: int = 28
static var character_desc_outline_size: int = 0
static var character_desc_shadow_offset_x: int = 4
static var character_desc_shadow_offset_y: int = 0

static var card_title_label_setting: LabelSettings
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
	
	# button
	button_label_font_size = theme.get_font_size("font_size", "MainMenuButton") if theme.has_font_size("font_size", "MainMenuButton") else 30
	button_label_font_color = theme.get_color("font_color", "MainMenuButton") if theme.has_color("font_color", "MainMenuButton") else Color.hex(-597249)
	button_label_outline_size = theme.get_constant("outline_size", "MainMenuButton") if theme.has_constant("outline_size", "MainMenuButton") else 12

	# top panel
	top_panel_font_normal_color = theme.get_color("font_normal_color", "SortHeader")
	top_panel_font_pressed_color = theme.get_color("font_pressed_color", "SortHeader")
	top_panel_font_shadow_color = theme.get_color("font_shadow_color", "SortHeader")
	top_panel_font_outline_color = theme.get_color("font_outline_color", "SortHeader")
	top_panel_info_font_size = theme.get_constant("font_size", "SortHeader")
	top_panel_info_outline_size = theme.get_constant("outline_size", "SortHeader")
	top_panel_info_shadow_offset_x = theme.get_constant("shadow_offset_x", "SortHeader")
	top_panel_info_shadow_offset_y = theme.get_constant("shadow_offset_y", "SortHeader")

	# panel
	panel_info_font_size = try_get_constant(theme, "font_size", "PanelInfo", 22)
	panel_info_outline_size = try_get_constant(theme, "outline_size", "PanelInfo", 0)
	panel_info_shadow_offset_x = try_get_constant(theme, "shadow_offset_x", "PanelInfo", 3)
	panel_info_shadow_offset_y = try_get_constant(theme, "shadow_offset_y", "PanelInfo", 3)

	# card title
	initialize_card_title()

	# desc
	card_desc_normal_color = theme.get_color("normal_color", "CardDescriptionLabel")
	card_desc_keyword_color = theme.get_color("keyword_color", "CardDescriptionLabel")
	# desc shadow
	card_desc_shadow_color = theme.get_color("shadow_color", "CardDescriptionLabel")
	card_desc_shadow_offset.x = try_get_constant(theme, "shadow_offset_x", "CardDescriptionLabel", 3)
	card_desc_shadow_offset.y = try_get_constant(theme, "shadow_offset_y", "CardDescriptionLabel", 3)
	large_card_desc_shadow_offset.x = try_get_constant(theme, "large_shadow_offset_x", "CardDescriptionLabel", 6)
	large_card_desc_shadow_offset.y = try_get_constant(theme, "large_shadow_offset_y", "CardDescriptionLabel", 6)
	

	# tab color
	tab_font_normal_color = theme.get_color("tab_font_normal_color", "CardLibraryScreen")
	tab_font_selected_color = theme.get_color("tab_font_selected_color", "CardLibraryScreen")

static func initialize_card_title() -> void:
	card_title_font_size = theme.get_font_size("font_size", "CardTitle") if theme.has_font_size("font_size", "CardTitle") else 32
	card_title_label_setting = LabelSettings.new()
	card_title_label_setting.font = get_regular_font()
	card_title_label_setting.font_size = card_title_font_size
	card_title_label_setting.font_color = Color.GOLD
	card_title_label_setting.outline_color = Color(0.35, 0.35, 0.35, 1)
	card_title_label_setting.outline_size = 4
	card_title_label_setting.shadow_color = QUARTER_TRANSPARENT_BLACK_COLOR
	card_title_label_setting.shadow_offset = Vector2(3, 3)
	

static func try_get_constant(targettheme: Theme, name: StringName, theme_type: StringName, default: int) -> int:
	return targettheme.get_font_size(name, theme_type) if targettheme.has_font_size(name, theme_type) else default

static func get_desc_string_size(line_str: String) -> Vector2:
	return normal_font_eng.get_string_size(line_str, HorizontalAlignment.HORIZONTAL_ALIGNMENT_LEFT, -1, card_desc_font_size)
	
static func get_desc_string_size_cn(line_str: String) -> Vector2:
	return normal_font_zhs.get_string_size(line_str, HorizontalAlignment.HORIZONTAL_ALIGNMENT_LEFT, -1, card_desc_font_size)

static func get_card_desc_font_size(use_large: bool) -> int:
	return large_card_desc_font_size if use_large else card_desc_font_size

static func get_regular_font() -> Font:
	if Settings.language == Settings.GameLanguage.ENG:
		return normal_font_eng
	
	if Settings.language == Settings.GameLanguage.ZHS:
		return normal_font_zhs
	
	return normal_font_eng

static func get_bold_font() -> Font:
	if Settings.language == Settings.GameLanguage.ENG:
		return bold_font_eng
	
	if Settings.language == Settings.GameLanguage.ZHS:
		return bold_font_zhs
	
	return bold_font_eng

static func get_italic_font() -> Font:
	if Settings.language == Settings.GameLanguage.ENG:
		return italic_font_eng
	
	if Settings.language == Settings.GameLanguage.ZHS:
		return italic_font_zhs
	
	return italic_font_eng

static func apply_label_font_style_with(label: Label, dict: Dictionary = {}) -> void:
	var label_font: Font = dict.get("font", get_regular_font())
	label.add_theme_font_override("font", label_font)

	label.add_theme_color_override("font_color", dict.get("font_color", CREAM_COLOR))
	label.add_theme_font_size_override("font_size", dict.get("font_size", label_font_size))

	label.add_theme_color_override("font_outline_color", dict.get("font_outline_color", HALF_TRANSPARENT_BLACK_COLOR))
	label.add_theme_constant_override("outline_size", dict.get("outline_size", label_outline_size))
	
	label.add_theme_color_override("font_shadow_color", dict.get("font_shadow_color", QUARTER_TRANSPARENT_BLACK_COLOR))
	label.add_theme_constant_override("shadow_offset_x", dict.get("shadow_offset_x", label_shadow_offset_x))
	label.add_theme_constant_override("shadow_offset_y", dict.get("shadow_offset_y", label_shadow_offset_y))
	if dict.has("shadow_outline_size"):
		label.add_theme_constant_override("shadow_outline_size", dict["shadow_outline_size"])

static func apply_rich_label_font_style_with(label: RichTextLabel, dict: Dictionary = {}) -> void:
	var label_font: Font = dict.get("normal_font", get_regular_font())
	label.add_theme_font_override("normal_font", label_font)
	label.add_theme_font_size_override("normal_font_size", dict.get("normal_font_size", card_desc_font_size))

	label.add_theme_color_override("default_color", dict.get("default_color", CREAM_COLOR))

	label.add_theme_color_override("font_outline_color", dict.get("font_outline_color", HALF_TRANSPARENT_BLACK_COLOR))
	label.add_theme_constant_override("outline_size", dict.get("outline_size", label_outline_size))
	
	label.add_theme_color_override("font_shadow_color", dict.get("font_shadow_color", QUARTER_TRANSPARENT_BLACK_COLOR))
	label.add_theme_constant_override("shadow_offset_x", dict.get("shadow_offset_x", label_shadow_offset_x))
	label.add_theme_constant_override("shadow_offset_y", dict.get("shadow_offset_y", label_shadow_offset_y))

	label.add_theme_constant_override("line_separation", dict.get("line_separation", 0))

static func apply_banner_name_font(label: Label) -> void:
	ThemeHelper.apply_label_font_style_with(label, {
		"font": get_bold_font(),
		"font_size": 72,
		"font_color": ThemeHelper.GOLD_COLOR,
		"font_outline_color": Color(0.0, 0.0, 0.0, 0.33),
		"outline_size": 8,
		"font_shadow_color": ThemeHelper.QUARTER_TRANSPARENT_BLACK_COLOR,
		"shadow_offset_x": 0,
		"shadow_offset_y": 0,
		})

static func apply_tip_header_font(label: Label, dict: Dictionary = {}) -> void:
	var font = dict.get("font", get_bold_font())
	ThemeHelper.apply_label_font_style_with(label, {
		"font": font,
		"font_size": 23,
		"font_color": dict.get("font_color", CREAM_COLOR),
		"font_outline_color": Color(0.3, 0.3, 0.3, 1),
		"outline_size": 2,
		"font_shadow_color": ThemeHelper.QUARTER_TRANSPARENT_BLACK_COLOR,
		"shadow_offset_x": 1,
		"shadow_offset_y": 1,
		})
static func apply_tip_header_font_to_richlabel(label: RichTextLabel, dict: Dictionary = {}) -> void:
	var font = dict.get("normal_font", get_bold_font())
	ThemeHelper.apply_rich_label_font_style_with(label, {
		"normal_font": font,
		"normal_font_size": 23,
		"default_color": dict.get("default_color", CREAM_COLOR),
		"font_outline_color": Color(0.3, 0.3, 0.3, 1),
		"outline_size": 2,
		"font_shadow_color": ThemeHelper.QUARTER_TRANSPARENT_BLACK_COLOR,
		"shadow_offset_x": 1,
		"shadow_offset_y": 1,
		})

static func apply_tip_body_font_to_richlabel(label: RichTextLabel, dict: Dictionary = {}) -> void:
	var font = dict.get("normal_font", get_regular_font())
	ThemeHelper.apply_rich_label_font_style_with(label, {
		"normal_font": font,
		"normal_font_size": 20,
		"default_color": dict.get("default_color", CREAM_COLOR),
		"font_outline_color": Color(0.4, 0.1, 0.1, 1),
		"outline_size": 0,
		"font_shadow_color": QUARTER_TRANSPARENT_BLACK_COLOR,
		"shadow_offset_x": 3,
		"shadow_offset_y": 3,
		})
static func apply_damage_number_font_style(label: Label, color_dict: Dictionary = {}) -> void:
	var damage_number_font: Font = get_regular_font()

	label.add_theme_font_override("font", damage_number_font)
	var normal = color_dict.get("font_color", Color.hex(0xefc851ff))
	apply_label_font_style_with(label, {
		"font_size": damage_number_font_size,
		"font_color": normal,
		"font_outline_color": Color.hex(0x241f14ff),
		"outline_size": damage_number_font_outline_size,
		"font_shadow_color": QUARTER_TRANSPARENT_BLACK_COLOR,
		"shadow_offset_x": damage_number_font_shadow_offset_x,
		"shadow_offset_y": damage_number_font_shadow_offset_y,
		})

static func apply_button_label_font_style(label: Label, dict: Dictionary = {}) -> void:
	if not dict.has("font"):
		dict["font"] = get_bold_font()
	if not dict.has("font_size"):
		dict["font_size"] = button_label_font_size
	if not dict.has("font_color"):
		dict["font_color"] = button_label_font_color
	if not dict.has("font_outline_color"):
		dict["font_outline_color"] = HALF_TRANSPARENT_BLACK_COLOR
	if not dict.has("outline_size"):
		dict["outline_size"] = button_label_outline_size
	if not dict.has("font_shadow_color"):
		dict["font_shadow_color"] = QUARTER_TRANSPARENT_BLACK_COLOR
	if not dict.has("shadow_offset_x"):
		dict["shadow_offset_x"] = button_label_shadow_offset_x
	if not dict.has("shadow_offset_y"):
		dict["shadow_offset_y"] = button_label_shadow_offset_y
	ThemeHelper.apply_label_font_style_with(label, dict)
	# label.add_theme_font_size_override("font_size", damage_number_font_size)
	
	# var normal = color_dict.get("font_color", Color.hex(0xefc851ff))
	# label.add_theme_color_override("font_color", normal)

	# label.add_theme_color_override("font_outline_color", color_dict.get("font_outline_color", Color.hex(0x241f14ff)))
	# label.add_theme_constant_override("outline_size", damage_number_font_outline_size)
	
	# label.add_theme_color_override("font_shadow_color", color_dict.get("font_shadow_color", QUARTER_TRANSPARENT_BLACK_COLOR))
	# label.add_theme_constant_override("shadow_offset_x", damage_number_font_shadow_offset_x)
	# label.add_theme_constant_override("shadow_offset_y", damage_number_font_shadow_offset_y)

static func apply_character_desc_font_style(label: Label, color_dict: Dictionary = {}) -> void:
	var character_desc_font: Font = get_regular_font()

	label.add_theme_font_override("font", character_desc_font)
	label.add_theme_font_size_override("font_size", character_desc_font_size)
	
	
	var normal = color_dict.get("font_color", CREAM_COLOR)
	label.add_theme_color_override("font_color", normal)

	label.add_theme_color_override("font_outline_color", color_dict.get("font_outline_color", Color.DARK_GRAY))
	label.add_theme_constant_override("outline_size", character_desc_outline_size)
	
	label.add_theme_color_override("font_shadow_color", color_dict.get("font_shadow_color", QUARTER_TRANSPARENT_BLACK_COLOR))
	label.add_theme_constant_override("shadow_offset_x", character_desc_shadow_offset_x)
	label.add_theme_constant_override("shadow_offset_y", character_desc_shadow_offset_y)


static func apply_card_title_font_style(label: Label, dict: Dictionary = {}) -> void:
	var card_title_font: Font = get_regular_font()
	if not dict.has("font"):
		dict["font"] = card_title_font
	if not dict.has("font_size"):
		dict["font_size"] = card_title_font_size
	if not dict.has("font_color"):
		dict["font_color"] = Color.GOLD
	if not dict.has("font_outline_color"):
		dict["font_outline_color"] = Color(0.35, 0.35, 0.35, 1)
	if not dict.has("outline_size"):
		dict["outline_size"] = button_label_outline_size
	if not dict.has("font_shadow_color"):
		dict["font_shadow_color"] = QUARTER_TRANSPARENT_BLACK_COLOR
	if not dict.has("shadow_offset_x"):
		dict["shadow_offset_x"] = button_label_shadow_offset_x
	if not dict.has("shadow_offset_y"):
		dict["shadow_offset_y"] = button_label_shadow_offset_y
	
	apply_label_font_style_with(label, dict)

static func apply_button_font_style_with_color(button: BaseButton, dict: Dictionary = {}) -> void:
	button.add_theme_font_override("font", dict.get("font", get_regular_font()))
	button.add_theme_font_size_override("font_size", dict.get("font_size", button_label_font_size))

	var normal = dict.get("font_color", button_label_font_color)
	const button_colors: Array = ["font_color", "font_focus_color", "font_pressed_color", "font_hover_color", "font_hover_pressed_color"]
	for color in button_colors:
		button.add_theme_color_override(color, dict.get(color, normal))

	button.add_theme_color_override("font_outline_color", dict.get("font_outline_color", HALF_TRANSPARENT_BLACK_COLOR))
	button.add_theme_constant_override("outline_size", dict.get("outline_size", button_label_outline_size))
	
	button.add_theme_color_override("font_shadow_color", dict.get("font_shadow_color", QUARTER_TRANSPARENT_BLACK_COLOR))
	button.add_theme_constant_override("shadow_offset_x", dict.get("shadow_offset_x", button_label_shadow_offset_x))
	button.add_theme_constant_override("shadow_offset_y", dict.get("shadow_offset_y", button_label_shadow_offset_y))

static func _apply_button_font_style(button: BaseButton) -> void:
	apply_button_font_style_with_color(button)


static func apply_confirm_button_style(button: BaseButton) -> void:
	clean_button_style(button)
	_apply_button_font_style(button)
	
	button.add_theme_color_override("font_hover_color", Color.WHITE)
	button.add_theme_color_override("font_hover_pressed_color", Color.WHITE)


static func apply_menu_button_style(button: BaseButton, fit_size: bool = false) -> void:
	clean_button_style(button)
	_apply_button_font_style(button)
	if fit_size:
		var button_label_font: Font = get_regular_font()
		button.custom_minimum_size = button_label_font.get_string_size(button.text, HORIZONTAL_ALIGNMENT_LEFT, -1, button_label_font_size)
		button.size = button.custom_minimum_size + Vector2(80, 0)


static func apply_top_panel_font_style(control: Control) -> void:
	var top_panel_info_font: Font = get_bold_font()
	control.add_theme_font_override("font", top_panel_info_font)
	control.add_theme_font_size_override("font_size", top_panel_info_font_size)
	
	control.add_theme_color_override("icon_color", top_panel_font_normal_color)
	control.add_theme_color_override("font_color", top_panel_font_normal_color)
	control.add_theme_color_override("font_shadow_color", top_panel_font_shadow_color)
	control.add_theme_color_override("font_outline_color", top_panel_font_outline_color)

	control.add_theme_constant_override("shadow_offset_x", top_panel_info_shadow_offset_x)
	control.add_theme_constant_override("shadow_offset_y", top_panel_info_shadow_offset_y)
	control.add_theme_constant_override("outline_size", top_panel_info_outline_size)


static func apply_panel_info_font_style(label: Label) -> void:
	var panel_info_font: Font = get_regular_font()
	label.add_theme_font_override("font", panel_info_font)
	label.add_theme_font_size_override("font_size", panel_info_font_size)
	label.add_theme_color_override("font_color", ThemeHelper.CREAM_COLOR)
	
	label.add_theme_color_override("font_shadow_color", ThemeHelper.QUARTER_TRANSPARENT_BLACK_COLOR)
	label.add_theme_color_override("font_outline_color", Color(0.35, 0.35, 0.35, 1.0))

	label.add_theme_constant_override("shadow_offset_x", panel_info_shadow_offset_x)
	label.add_theme_constant_override("shadow_offset_y", panel_info_shadow_offset_y)
	label.add_theme_constant_override("outline_size", panel_info_outline_size)


static func clean_button_style(button: BaseButton) -> void:
	button.add_theme_stylebox_override("focus", STYLE_BOX_EMPTY)
	button.add_theme_stylebox_override("hover", STYLE_BOX_EMPTY)
	button.add_theme_stylebox_override("hover_pressed", STYLE_BOX_EMPTY)
	button.add_theme_stylebox_override("pressed", STYLE_BOX_EMPTY)
	button.add_theme_stylebox_override("normal", STYLE_BOX_EMPTY)
	
static func initialize_richtextlabel_style(label: RichTextLabel) -> void:
	label.bbcode_enabled = true
	label.threaded = true
	label.scroll_active = false
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_TOP
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	label.autowrap_mode = TextServer.AUTOWRAP_OFF
	label.clip_contents = false
