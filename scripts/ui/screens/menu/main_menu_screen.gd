class_name MainMenuScreen
extends Control

enum Screen {MAIN_MENU, PANEL_MENU, CHARACTER_SELECT, SETTINGS, CARD_LIBRARY, NONE, ABANDON_CONFIRM, PATCH_NOTES, IN_DEVELOP}
enum PanelScreen {NONE, PLAY, COMPENDIUM, STATS, SETTINGS}


var cur_screen: Screen = Screen.MAIN_MENU
var cur_panel_screen: PanelScreen = PanelScreen.NONE
var abadon_run: bool = false

@export var menu_buttons: MenuButtons = null
@export_group("")

@export var title_background: TitleBackground = null
@export_group("Sub Screen")
@export var character_select_screen: CharacterSelectScreen = null
@export var menu_panel_screen: MenuPanelScreen = null
@export var card_library: CardLibraryScreen = null
@export var confirm_popup: ConfirmPopup = null
@export_group("")

@export_group("BlackMask")
@export var black_mask: TextureRect = null
@export_group("")

@export_group("Setting")
@export var setting_screen: SettingsScreen = null
@export_group("")

@export_group("Gameplay")
@export var dungeon_prefab: PackedScene = null
@export_group("")
var is_super_darken: bool = false
var is_darken: bool = false
var main_menu_screen: MainMenuScreen = null

static func initialize() -> void:
	MenuButtons.initialize()
	CharacterSelectScreen.initialize()

func _ready() -> void:
	CardGame.main_menu_screen = self
	
	title_background.main_menu_screen = self
	menu_buttons.main_menu_screen = self
	black_mask.self_modulate = Color.BLACK
	
	menu_panel_screen.main_menu_screen = self
	menu_panel_screen.cancel_button.button.pressed.connect(close_screen)
	menu_panel_screen.cancel_click_event = close_screen

	setting_screen.close(true)
	setting_screen.exit_button.pressed.connect(get_tree().quit)
	CardGame.sound.loop_play("WIND")
	

func _process(_delta: float) -> void:
	if not title_background.activated:
		if card_library.initialized:
			title_background.activate()
			CardGame.music.change_bgm("MENU")
		return

	menu_buttons.slider = title_background.slider
	is_super_darken = character_select_screen.visible && character_select_screen.any_selected
	if is_super_darken:
		black_mask.self_modulate.a = MathHelper.lerp_snap(black_mask.self_modulate.a, 1.0, _delta * 12.0)
	elif is_darken:
		black_mask.self_modulate.a = MathHelper.lerp_snap(black_mask.self_modulate.a, 0.8, _delta * 12.0)
	else:
		black_mask.self_modulate.a = MathHelper.lerp_snap(black_mask.self_modulate.a, 0.0, _delta * 12.0)


func _input(event: InputEvent):
	if event is InputEventKey:
		var key_event: InputEventKey = event as InputEventKey
		if key_event.keycode == KEY_ESCAPE and key_event.is_pressed():
			escape()
			
func open_panel(panel_screen: PanelScreen) -> void:
	hide_buttons()
	darken()
	cur_screen = Screen.PANEL_MENU
	cur_panel_screen = panel_screen
	match cur_panel_screen:
		PanelScreen.PLAY:
			menu_panel_screen.open_panel(panel_screen)
		PanelScreen.COMPENDIUM:
			menu_panel_screen.open_panel(panel_screen)
		PanelScreen.STATS:
			menu_panel_screen.open_panel(panel_screen)
		PanelScreen.SETTINGS:
			menu_panel_screen.open_panel(panel_screen)
	return

func open_screen(target_screen: Screen) -> void:
	cur_screen = target_screen
	if cur_screen != Screen.MAIN_MENU:
		hide_buttons()
		darken()
	match target_screen:
		Screen.MAIN_MENU:
			return
		Screen.CHARACTER_SELECT:
			character_select_screen.open(go_to_gameplay, close_screen)
			return
		Screen.SETTINGS:
			setting_screen.open(close_screen)
			return
		Screen.CARD_LIBRARY:
			card_library.open(close_screen)
			return
		Screen.ABANDON_CONFIRM:
			confirm_popup.open("功能开发中，暂无有效功能。", close_screen, close_screen)
			return
		Screen.PATCH_NOTES:
			confirm_popup.open("功能开发中，暂无有效功能。", close_screen, close_screen)
			return
		Screen.NONE:
			return
		Screen.IN_DEVELOP:
			confirm_popup.open("功能开发中，暂无有效功能。", close_screen, close_screen)
			return
		_:
			print("unknown screen: %s" % target_screen)

func hide_buttons() -> void:
	menu_buttons.hide()

func close_screen() -> void:
	match cur_screen:
		Screen.PANEL_MENU:
			menu_panel_screen.close()
			cur_panel_screen = PanelScreen.NONE
		Screen.CHARACTER_SELECT:
			character_select_screen.close()
			is_super_darken = false
		Screen.SETTINGS:
			setting_screen.close()
		Screen.CARD_LIBRARY:
			if card_library.single_card_popup.visible:
				card_library.single_card_popup.close()
				return
			card_library.close()
		Screen.ABANDON_CONFIRM:
			pass
		Screen.PATCH_NOTES:
			pass
		Screen.NONE:
			pass
		Screen.IN_DEVELOP:
			pass

	
	if cur_panel_screen != PanelScreen.NONE:
		open_panel(cur_panel_screen)
	else:
		cur_screen = Screen.MAIN_MENU
		menu_buttons.show()
		lighten()

func escape() -> void:
	if cur_screen == Screen.MAIN_MENU:
		open_screen(MainMenuScreen.Screen.SETTINGS)
	else:
		if confirm_popup.visible:
			confirm_popup.hide()
		close_screen()

func go_to_gameplay() -> void:
	CardGame.disable_input("button")
	character_select_screen.confirm_button.hide_button()
	fade_out_music()
	
	CardGame.black_mask.fade_in(load_gameplay)
	# if Settings.seed < 0:
	# 	Settings.set_seed()
	# else:
	# 	Settings.seedSet = true

func load_gameplay() -> void:
	# 加载新场景，卸载当前节点相关内容
	queue_free()
	CardGame.load_new_dungeon(dungeon_prefab)

func darken() -> void:
	is_darken = true


func lighten() -> void:
	is_darken = false
	is_super_darken = false


func fade_out_music() -> void:
	CardGame.music.fade_out_bgm()
	CardGame.sound.fade_out("WIND");
