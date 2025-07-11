extends Node

enum GameState {
	MENU,
	GAMEPLAY,
	DUNGEON_TRANSITION,
	GAME_OVER
}

var main_menu_screen: MainMenuScreen = null
var playerConfig: ConfigFile
var languagePack: LocalizedString = null
var state: GameState = GameState.MENU

# nodes
var cardtip: CardTipMaster = null
var camera: Camera2D = null
var music: MusicMaster = null
var sound: SoundMaster = null
var screen_shake: ScreenShake = null
var mouse_cursor: MouseCursor = null
var black_mask: BlackMask = null
# custom resource
var interpolation: Interpolation = null
func _ready() -> void:
	# Initialize the game settings and player configuration
	initialize()

	load_resources()

	create_nodes()


func initialize() -> void:
	print("Initializing...")
	Settings.initialize()
	
	playerConfig = SaveHelper.get_config("player");
	languagePack = LocalizedString.new()
	

	GameDictionary.initialize(languagePack)
	ImageMaster.initialize()
	ThemeHelper.initialize()
	AbstractCard.initialize()
	AbstractPlayer.initialize()
	AbstractRelic.initialize()
	MainMenuScreen.initialize()
	CardLibrary.initialize()
	RelicLibrary.initialize()
	CharacterManager.initialize()

	DungeonTransitionScreen.initialize()
func exist_saved_game() -> bool:
	return false

func create_nodes() -> void:
	var screenSize = Vector2i(Settings.WIDTH, Settings.HEIGHT)

	cardtip = CardTipMaster.new()
	cardtip.name = "CardTipMaster"
	add_child(cardtip)

	camera = Camera2D.new()
	camera.name = "Camera2D"
	add_child(camera)
	camera.set_deferred("position", screenSize / 2)

	music = MusicMaster.new()
	music.name = "MusicMaster"
	add_child(music)

	sound = SoundMaster.new()
	sound.name = "SoundMaster"
	add_child(sound)

	screen_shake = ScreenShake.new()
	screen_shake.name = "ScreenShake"
	add_child(screen_shake)

	mouse_cursor = MouseCursor.new()
	mouse_cursor.name = "MouseCursor"
	add_child(mouse_cursor)

	black_mask = BlackMask.new()
	black_mask.name = "BlackMask"
	add_child(black_mask)
	black_mask.set_deferred("size", screenSize)

	# var setting_panel_scene: PackedScene = load("res://scenes/slay_the_spire/ui/options/settings_panel.tscn")
	# settings_panel = setting_panel_scene.instantiate()
	# add_child(settings_panel)

	
func load_resources() -> void:
	interpolation = load("res://arts/resources/Interpolation.tres")


func disable_input(group_name: String) -> void:
	for node in get_tree().get_nodes_in_group(group_name):
		if node is Control:
			(node as Control).mouse_filter = Control.MOUSE_FILTER_IGNORE

func enable_input(group_name: String) -> void:
	for node in get_tree().get_nodes_in_group(group_name):
		if node is Control:
			(node as Control).mouse_filter = Control.MOUSE_FILTER_STOP
