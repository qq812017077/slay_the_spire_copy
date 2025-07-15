class_name CharacterSelectScreen
extends Control

static var ui_string: UIString = null
static var TEXT: Array = []
static var ui_string2: UIString = null
static var A_TEXT: Array = []

const SEED_X = 60
const SEED_Y = 60

static var CHOOSE_CHAR_MSG: String

@export var cancel_button: ScreenButton = null
@export var confirm_button: ScreenButton = null
@export var character_bg: TextureRect = null

@export_group("Choose Character Message")
@export var choose_character_label: Label = null
@export_group("")
@export_group("Options")
@export var button_group: ButtonGroup = null
@export var options: Array[CharacterOption] = []
@export_group("")
@export var character_infos_container: Control = null
var confirm_click_event: Callable
var cancel_click_event: Callable

var any_selected: bool = false
var cur_option: CharacterOption = null
static func initialize() -> void:
	ui_string = CardGame.languagePack.get_ui_string("CharacterSelectScreen")
	TEXT = ui_string.TEXT
	ui_string2 = CardGame.languagePack.get_ui_string("AscensionModeDescriptions")
	A_TEXT = ui_string2.TEXT

	CHOOSE_CHAR_MSG = TEXT[0]

	CharacterOption.initialize()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ThemeHelper.apply_label_font_style_with(choose_character_label, {
		"font_size": 42,
		"font_outline_color": Color(0.3, 0.3, 0.3, 1),
		"outline_size": 15,
		})

	choose_character_label.text = CHOOSE_CHAR_MSG
	confirm_button.button.text = TEXT[1]
	confirm_button.button.pressed.connect(_confirm_clicked)
	cancel_button.button.text = TEXT[5]
	cancel_button.button.pressed.connect(_cancel_clicked)

	for option in options:
		option.button_group = button_group
		option.toggled.connect(_on_toggle_changed.bind(option))
		option.mouse_entered.connect(_on_mouse_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var cur_any_selected = false
	for option in options:
		if option.button_pressed:
			cur_any_selected = true
			break
	
	if any_selected != cur_any_selected:
		any_selected = cur_any_selected
		if any_selected:
			character_infos_container.visible = true
			choose_character_label.visible = false
			confirm_button.show_button()
			character_bg.self_modulate.a = MathHelper.lerp_snap(character_bg.self_modulate.a, 1.0, delta * 12.0)
		else:
			character_infos_container.visible = false
			choose_character_label.visible = true
			confirm_button.hide_button()
			character_bg.self_modulate.a = MathHelper.lerp_snap(character_bg.self_modulate.a, 0.0, delta * 12.0)

	if any_selected:
		character_bg.self_modulate.a = MathHelper.lerp_snap(character_bg.self_modulate.a, 1.0, delta * 12.0)
	else:
		character_bg.self_modulate.a = MathHelper.lerp_snap(character_bg.self_modulate.a, 0.0, delta * 12.0)


func open(confirm_event: Callable = Callable(), cancel_event: Callable = Callable()) -> void:
	self.show()
	cancel_button.show_button()
	confirm_button.hide_button()
	confirm_click_event = confirm_event
	cancel_click_event = cancel_event

func close() -> void:
	CardGame.main_menu_screen.is_super_darken = false
	for option in options:
		option.set_pressed_no_signal(false)
	
	hide()
	cancel_button.hide_button(true)
	confirm_button.hide_button(true)
	cur_option = null

func _confirm_clicked() -> void:
	if confirm_click_event.is_valid():
		confirm_click_event.call()
		# close()

func _cancel_clicked() -> void:
	if cancel_click_event.is_valid():
		cancel_click_event.call()


func _on_mouse_entered() -> void:
	CardGame.sound.single_play("UI_HOVER", -0.3)

func _on_toggle_changed(_toggle: bool, option: CharacterOption) -> void:
	if cur_option == option:
		return
	cur_option = option
	if _toggle:
		CardGame.sound.single_play("UI_CLICK_1", -0.4)
		option.timer = 0
		character_bg.texture = option.portrait_img
		option.play_effect()
