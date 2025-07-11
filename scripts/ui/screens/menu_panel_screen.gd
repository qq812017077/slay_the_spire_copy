class_name MenuPanelScreen
extends Control

enum PanelType {PLAY_NORMAL, PLAY_DAILY, PLAY_CUSTOM, INFO_CARD, INFO_RELIC, INFO_POTION, STAT_CHAR, STAT_LEADERBOARDS, STAT_HISTORY, SETTINGS_GAME, SETTINGS_INPUT, SETTINGS_CREDITS}
enum PanelColor {RED, BLUE, BEIGE, GRAY}

static var PANEL_BG_BLUE: Texture2D = load("res://arts/slay_the_spire/images/ui/menu/menuPanel.png")
static var PANEL_BG_GRAY: Texture2D = load("res://arts/slay_the_spire/images/ui/menu/menuPanel4.png")
static var PANEL_BG_RED: Texture2D = load("res://arts/slay_the_spire/images/ui/menu/menuPanel3.png")
static var PANEL_BG_BEIGE: Texture2D = load("res://arts/slay_the_spire/images/ui/menu/menuPanel2.png")


static var ui_string: UIString = null
static var TEXT: Array = []

var main_menu_screen: MainMenuScreen = null

@export var cur_panel_screen: MainMenuScreen.PanelScreen = MainMenuScreen.PanelScreen.NONE
@export var panel_buttons: Array[MainMenuPanelButton] = []
@export var cancel_button: ScreenButton = null
@export var confirm_button: ScreenButton = null

var confirm_click_event: Callable
var cancel_click_event: Callable
var panel_button_click_event: Callable

func _ready() -> void:
	if ui_string == null:
		# print("invoke generate MenuPanels texts")
		ui_string = CardGame.languagePack.get_ui_string("MenuPanels")
		TEXT = ui_string.TEXT

	cancel_button.button.text = CardGame.languagePack.get_ui_string("CharacterSelectScreen").TEXT[5]
	
	confirm_button.button.pressed.connect(_confirm_clicked)
	cancel_button.button.pressed.connect(_cancel_clicked)
	
	for panel_button in panel_buttons:
		# panel_button.refresh()
		panel_button.button.mouse_entered.connect(_on_panel_button_entered)
		panel_button.button.pressed.connect(_on_panel_button_click.bind(panel_button))

func open_panel(panel_screen: MainMenuScreen.PanelScreen) -> void:
	cur_panel_screen = panel_screen
	show()
	cancel_button.show_button()
	match cur_panel_screen:
		MainMenuScreen.PanelScreen.PLAY:
			set_panel_buton(panel_buttons[0], PanelType.PLAY_NORMAL, PanelColor.BEIGE)
			set_panel_buton(panel_buttons[1], PanelType.PLAY_DAILY, PanelColor.BLUE)
			set_panel_buton(panel_buttons[2], PanelType.PLAY_CUSTOM, PanelColor.RED)
		MainMenuScreen.PanelScreen.COMPENDIUM:
			set_panel_buton(panel_buttons[0], PanelType.INFO_CARD, PanelColor.BEIGE)
			set_panel_buton(panel_buttons[1], PanelType.INFO_RELIC, PanelColor.BLUE)
			set_panel_buton(panel_buttons[2], PanelType.INFO_POTION, PanelColor.RED)
		MainMenuScreen.PanelScreen.STATS:
			set_panel_buton(panel_buttons[0], PanelType.STAT_CHAR, PanelColor.BEIGE)
			set_panel_buton(panel_buttons[1], PanelType.STAT_LEADERBOARDS, PanelColor.BLUE)
			set_panel_buton(panel_buttons[2], PanelType.STAT_HISTORY, PanelColor.RED)
		MainMenuScreen.PanelScreen.SETTINGS:
			set_panel_buton(panel_buttons[0], PanelType.SETTINGS_GAME, PanelColor.BEIGE)
			set_panel_buton(panel_buttons[1], PanelType.SETTINGS_INPUT, PanelColor.BLUE)
			set_panel_buton(panel_buttons[2], PanelType.SETTINGS_CREDITS, PanelColor.RED)
	for panel_button in panel_buttons:
		panel_button.refresh()
	
func close() -> void:
	if not visible:
		return
	hide()
	match cur_panel_screen:
		MainMenuScreen.PanelScreen.PLAY:
			pass
		MainMenuScreen.PanelScreen.COMPENDIUM:
			pass
		MainMenuScreen.PanelScreen.STATS:
			pass
		MainMenuScreen.PanelScreen.SETTINGS:
			pass
	cancel_button.hide_button(true)

func refresh() -> void:
	cancel_button.hide_button(true)
	open_panel(cur_panel_screen)

func _confirm_clicked() -> void:
	if confirm_click_event.is_valid():
		confirm_click_event.call()

func _cancel_clicked() -> void:
	if cancel_click_event.is_valid():
		cancel_click_event.call()


func set_panel_buton(menu_panel_button: MainMenuPanelButton, panel_type: PanelType, panel_color: PanelColor) -> void:
	var panel_texture: Texture2D = get_panel_texture(panel_color)
	menu_panel_button.panel_type = panel_type
	match panel_type:
		PanelType.PLAY_NORMAL:
			menu_panel_button.header.text = TEXT[0]
			menu_panel_button.description.text = TEXT[2]
			menu_panel_button.panel_img.texture = panel_texture
			menu_panel_button.portrait_img.texture = ImageMaster.PORTRAIT_STANDARD
		PanelType.PLAY_DAILY:
			menu_panel_button.header.text = TEXT[3]
			menu_panel_button.description.text = TEXT[5]
			menu_panel_button.panel_img.texture = panel_texture
			menu_panel_button.portrait_img.texture = ImageMaster.PORTRAIT_DAILY
		PanelType.PLAY_CUSTOM:
			menu_panel_button.header.text = TEXT[39]
			menu_panel_button.description.text = TEXT[37] if panel_color == PanelColor.GRAY else TEXT[40]
			menu_panel_button.panel_img.texture = panel_texture
			menu_panel_button.portrait_img.texture = ImageMaster.PORTRAIT_LOOP
		PanelType.INFO_CARD:
			menu_panel_button.header.text = TEXT[9]
			menu_panel_button.description.text = TEXT[11]
			menu_panel_button.panel_img.texture = panel_texture
			menu_panel_button.portrait_img.texture = ImageMaster.PORTRAIT_INFO_CARD
		PanelType.INFO_RELIC:
			menu_panel_button.header.text = TEXT[12]
			menu_panel_button.description.text = TEXT[14]
			menu_panel_button.panel_img.texture = panel_texture
			menu_panel_button.portrait_img.texture = ImageMaster.PORTRAIT_INFO_RELIC
		PanelType.INFO_POTION:
			menu_panel_button.header.text = TEXT[43]
			menu_panel_button.description.text = TEXT[44]
			menu_panel_button.panel_img.texture = panel_texture
			menu_panel_button.portrait_img.texture = ImageMaster.PORTRAIT_INFO_POTION
		PanelType.STAT_CHAR:
			menu_panel_button.header.text = TEXT[18]
			menu_panel_button.description.text = TEXT[20]
			menu_panel_button.panel_img.texture = panel_texture
			menu_panel_button.portrait_img.texture = ImageMaster.PORTRAIT_STAT_CHAR
		PanelType.STAT_LEADERBOARDS:
			menu_panel_button.header.text = TEXT[21]
			menu_panel_button.description.text = TEXT[23]
			menu_panel_button.panel_img.texture = panel_texture
			menu_panel_button.portrait_img.texture = ImageMaster.PORTRAIT_STAT_LEADERBOARD
		PanelType.STAT_HISTORY:
			menu_panel_button.header.text = TEXT[24]
			menu_panel_button.description.text = TEXT[26]
			menu_panel_button.panel_img.texture = panel_texture
			menu_panel_button.portrait_img.texture = ImageMaster.PORTRAIT_STAT_HISTORY
		PanelType.SETTINGS_GAME:
			menu_panel_button.header.text = TEXT[27]
			menu_panel_button.description.text = TEXT[42]
			menu_panel_button.panel_img.texture = panel_texture
			menu_panel_button.portrait_img.texture = ImageMaster.PORTRAIT_SETTING_GAME
		PanelType.SETTINGS_INPUT:
			menu_panel_button.header.text = TEXT[30]
			menu_panel_button.description.text = TEXT[41]
			menu_panel_button.panel_img.texture = panel_texture
			menu_panel_button.portrait_img.texture = ImageMaster.PORTRAIT_SETTING_INPUT
		PanelType.SETTINGS_CREDITS:
			menu_panel_button.header.text = TEXT[33]
			menu_panel_button.description.text = TEXT[35]
			menu_panel_button.panel_img.texture = panel_texture
			menu_panel_button.portrait_img.texture = ImageMaster.PORTRAIT_SETTING_CREDITS

	return
func _on_panel_button_entered() -> void:
	CardGame.sound.single_play("UI_HOVER").modify_volume(0.5)

func _on_panel_button_click(panel_button: MainMenuPanelButton) -> void:
	CardGame.sound.single_play("DECK_OPEN") # .modify_volume(0.5)
	match panel_button.panel_type:
		PanelType.PLAY_NORMAL:
			main_menu_screen.open_screen(MainMenuScreen.Screen.CHARACTER_SELECT)
		PanelType.PLAY_DAILY:
			return
		PanelType.PLAY_CUSTOM:
			return
		PanelType.INFO_CARD:
			main_menu_screen.open_screen(MainMenuScreen.Screen.CARD_LIBRARY)
		PanelType.INFO_RELIC:
			return
		PanelType.INFO_POTION:
			return
		PanelType.STAT_CHAR:
			return
		PanelType.STAT_LEADERBOARDS:
			return
		PanelType.STAT_HISTORY:
			return
		PanelType.SETTINGS_GAME:
			main_menu_screen.open_screen(MainMenuScreen.Screen.SETTINGS)
		PanelType.SETTINGS_INPUT:
			return
		PanelType.SETTINGS_CREDITS:
			return

	if panel_button_click_event.is_valid():
		panel_button_click_event.call(panel_button)

	close()
static func get_panel_texture(panel_color: PanelColor) -> Texture2D:
	match panel_color:
		PanelColor.RED:
			return PANEL_BG_RED
		PanelColor.BLUE:
			return PANEL_BG_BLUE
		PanelColor.BEIGE:
			return PANEL_BG_BEIGE
		PanelColor.GRAY:
			return PANEL_BG_GRAY
	return
