class_name SettingsScreen
extends Control

static var settings_ui_string: UIString = null
static var SETTINGS_TEXT: Array
static var options_ui_string: UIString = null
static var OPTION_TEXT: Array

static var abandon_ui_string: UIString = null
static var exit_ui_string: UIString = null


@export_group("Tab")
@export var game_settings_button: ButtonEx = null
@export var input_settings_button: ButtonEx = null
@export_group("")
@export_group("Button")
@export var abadon_button: ButtonEx = null
@export var exit_button: ButtonEx = null
@export_group("")

@onready var cancel_button: ScreenButton = $CancelButton

var cancel_click_event: Callable
func _ready() -> void:
	if settings_ui_string == null:
		settings_ui_string = CardGame.languagePack.get_ui_string("SettingsScreen")
		options_ui_string = CardGame.languagePack.get_ui_string("OptionsPanel")
		abandon_ui_string = CardGame.languagePack.get_ui_string("AbandonRunButton")
		exit_ui_string = CardGame.languagePack.get_ui_string("ExitGameButton")

		SETTINGS_TEXT = settings_ui_string.TEXT
		OPTION_TEXT = options_ui_string.TEXT
		
	
	z_index = Global.SETTINGS_INDEX

	initialize_tab()
	initialize_labels()
	initialize_buttons()
	close(true)
	
	cancel_button.button.text = SETTINGS_TEXT[4]
	cancel_button.button.pressed.connect(_cancel_clicked)

func open(cancel_event: Callable = Callable()) -> void:
	cancel_button.show_button()
	visible = true
	if CardGame.state == CardGame.GameState.GAMEPLAY:
		abadon_button.visible = true
		exit_button.set_label(OPTION_TEXT[16])
	else:
		abadon_button.visible = false
		exit_button.set_label(OPTION_TEXT[15])
	
	cancel_click_event = cancel_event

func close(instant: bool = false) -> void:
	visible = false
	cancel_button.hide_button(instant)

func initialize_tab():
	var setting_btn_group = ButtonGroup.new()
	game_settings_button.button_group = setting_btn_group
	input_settings_button.button_group = setting_btn_group

	for button: ButtonEx in [game_settings_button, input_settings_button]:
		ThemeHelper.clean_button_style(button)
		button.button_group = setting_btn_group
		ThemeHelper.apply_button_label_font_style(button.label, {
			"font_size": 34,
			"font_color": Color.WHITE,
			"outline_size": 1
		})

		button.toggle_mode = true
		button.label_hover_color = ThemeHelper.GOLD_COLOR
		button.action_mode = BaseButton.ACTION_MODE_BUTTON_PRESS
		button.pressed.connect(_on_tab_clicked.bind(button))

	game_settings_button.set_label(OPTION_TEXT[1])
	input_settings_button.set_label(OPTION_TEXT[20])
	game_settings_button.button_pressed = true

func initialize_labels():
	var panel_labels: Array = [$GameSettings/Graphcis/Label, $GameSettings/Sound/Label, $GameSettings/Preferences/Label, $GameSettings/Miscellaneous/Label]
	var texts: Array = [OPTION_TEXT[2], OPTION_TEXT[5], OPTION_TEXT[8], OPTION_TEXT[12]]
	var idx = 0
	for panel_label: Label in panel_labels:
		panel_label.text = texts[idx]
		ThemeHelper.apply_button_label_font_style(panel_label, {
			"font_size": 34,
			"font_color": ThemeHelper.GOLD_COLOR,
			"outline_size": 1
		})
		idx += 1

func _on_tab_clicked(btn: ButtonEx) -> void:
	if btn == game_settings_button:
		$GameSettings.visible = true
	elif btn == input_settings_button:
		$GameSettings.visible = false

func initialize_buttons():
	var texts: Array = [abandon_ui_string.TEXT[0], exit_ui_string.TEXT[0]]
	var outline_colors: Array = [Color.hex(0x5d2e27b0), Color.hex(0x473c18ff)]
	var idx: int = 0
	var font_sizes: Array = [32, 36]
	for button: ButtonEx in [abadon_button, exit_button]:
		ThemeHelper.clean_button_style(button)
		button.set_label(texts[idx])

		ThemeHelper.apply_button_label_font_style(button.label, {
			"font_size": font_sizes[idx],
			"font_color": ThemeHelper.GOLD_COLOR,
			"font_outline_color": outline_colors[idx],
			"outline_size": font_sizes[idx] / 2,
			"shadow_outline_size": font_sizes[idx] / 2
		})
		idx += 1

		button.texture_hover_color = Color.WHITE * 1.2
		button.label_hover_color = Color.WHITE * 1.1


func _cancel_clicked():
	if cancel_click_event.is_valid():
		cancel_click_event.call()
