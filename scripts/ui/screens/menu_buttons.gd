@tool
class_name MenuButtons
extends Node

static var ui_strings: UIString = null
static var TEXT: Array = []
@export_range(0.0, 1.0) var slider: float = 0.0
@export var START_POS: Vector2i = Vector2i(0, 120)
@export_range(20, 200) var SPACE_Y: int = 20

@export_group("Animation")
@export var circle_in_curve: Curve = null
@export_group("")

@export_group("Buttons")
@export var quit_button: MainMenuButton = null
@export var patch_note_button: MainMenuButton = null
@export var settings_button: MainMenuButton = null
@export var stat_button: MainMenuButton = null
@export var info_button: MainMenuButton = null
@export var abadon_button: MainMenuButton = null
@export var continue_button: MainMenuButton = null
@export var play_button: MainMenuButton = null
@export_group("")

@export var hidden: bool = false
var main_menu_screen: MainMenuScreen = null

var buttons: Array[MainMenuButton] = []
var visible_buttons: Array[MainMenuButton] = []
# var abadon_run: bool = false

static func initialize() -> void:
	ui_strings = CardGame.languagePack.get_ui_string("MenuButton")
	TEXT = ui_strings.TEXT
	MainMenuButton.initialize()


func _ready() -> void:
	buttons = [quit_button, patch_note_button, settings_button, stat_button, info_button, abadon_button, continue_button, play_button]

	for button in buttons:
		button.pressed.connect(on_button_pressed.bind(button.click_result))
		button.mouse_entered.connect(on_button_mouse_entered)
	visible_buttons.append(quit_button)
	visible_buttons.append(patch_note_button)
	visible_buttons.append(settings_button)
	visible_buttons.append(stat_button)
	visible_buttons.append(info_button)
	

	if Engine.is_editor_hint():
		abadon_button.visible = false
		continue_button.visible = false
		play_button.visible = false
		return

	if CardGame.exist_saved_game():
		abadon_button.visible = true
		continue_button.visible = true
		play_button.visible = false
		visible_buttons.append(abadon_button)
		visible_buttons.append(continue_button)
	else:
		abadon_button.visible = false
		continue_button.visible = false
		play_button.visible = true
		visible_buttons.append(play_button)

	config_buttons()
	
	
func _process(delta: float) -> void:
	update_buttons_position(delta)
	if Engine.is_editor_hint():
		return
	
	for button in visible_buttons:
		if hidden:
			button.highlight_alpha = 0
		elif button.is_hovered():
			button.targetX_offset = 30
			button.highlight_alpha = 1
		elif !hidden:
			button.targetX_offset = 0
			button.highlight_alpha = MathHelper.lerp_snap(button.highlight_alpha, 0.0, delta * 12.0)


func hide() -> void:
	hidden = true
	for idx in range(visible_buttons.size()):
		var main_menu_button = visible_buttons[idx] as MainMenuButton
		main_menu_button.targetX_offset = -600 + 50 * idx

func show() -> void:
	hidden = false

func abadon_run():
	abadon_button.visible = false
	continue_button.visible = false
	play_button.visible = true

func update_buttons_position(delta: float) -> void:
	var lerper = circle_in_curve.sample(slider) if circle_in_curve else slider
	
	if Engine.is_editor_hint():
		for idx in range(visible_buttons.size()):
			var sliderX: float = -250.0 * lerper - idx * 80 * lerper
			visible_buttons[idx].position = Vector2(START_POS.x + 75 + sliderX, START_POS.y - idx * SPACE_Y)
		return

	for idx in range(visible_buttons.size()):
		var main_menu_button: MainMenuButton = visible_buttons[idx]
		main_menu_button.x_offset = MathHelper.lerp_snap(main_menu_button.x_offset, main_menu_button.targetX_offset, delta * 9.0)
		var sliderX: float = -250.0 * lerper - idx * 80 * lerper
		visible_buttons[idx].position = Vector2(main_menu_button.x_offset + START_POS.x + 75 + sliderX, START_POS.y - idx * SPACE_Y)
		main_menu_button.highlight_tex.self_modulate.a = main_menu_button.highlight_alpha
		

func config_buttons() -> void:
	# text config 
	var button_texts: Array = [TEXT[8], TEXT[9], TEXT[12], TEXT[6], TEXT[14], TEXT[10], TEXT[4], TEXT[1]]
	var space: String = "  "
	for idx in range(buttons.size()):
		buttons[idx].text = space + button_texts[idx]


func on_button_pressed(click_result: MainMenuButton.ClickResult) -> void:
	# print("button pressed: %s" % MainMenuButton.ClickResult.keys()[click_result])
	CardGame.sound.single_play("UI_CLICK_1", - 0.1)
	match click_result:
		MainMenuButton.ClickResult.PLAY:
			main_menu_screen.open_panel(MainMenuScreen.PanelScreen.PLAY)
			return
		MainMenuButton.ClickResult.RESUME_GAME:
			main_menu_screen.open_screen(MainMenuScreen.Screen.NONE)
			return
		MainMenuButton.ClickResult.ABANDON_RUN:
			main_menu_screen.open_screen(MainMenuScreen.Screen.ABANDON_CONFIRM)
			return
		MainMenuButton.ClickResult.INFO:
			main_menu_screen.open_panel(MainMenuScreen.PanelScreen.COMPENDIUM)
			return
		MainMenuButton.ClickResult.STAT:
			main_menu_screen.open_panel(MainMenuScreen.PanelScreen.STATS)
			return
		MainMenuButton.ClickResult.SETTINGS:
			main_menu_screen.open_panel(MainMenuScreen.PanelScreen.SETTINGS)
			return
		MainMenuButton.ClickResult.PATCH_NOTES:
			main_menu_screen.open_screen(MainMenuScreen.Screen.PATCH_NOTES)
			return
		MainMenuButton.ClickResult.QUIT:
			get_tree().quit()
			return
	
	print("unknown pressed: %s" % click_result)
	return

func on_button_mouse_entered() -> void:
	CardGame.sound.single_play("UI_HOVER", - 0.1)
