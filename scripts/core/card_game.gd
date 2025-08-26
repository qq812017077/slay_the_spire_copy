extends Node

enum GameState {
	MENU,
	GAMEPLAY,
	DUNGEON_TRANSITION,
	GAME_OVER
}

var is_focused: bool = true

var main_menu_screen: MainMenuScreen = null
var dungeon_main_screen: DungeonMainScreen = null
var playerConfig: ConfigFile
var languagePack: LocalizedString = null
var state: GameState = GameState.MENU

# nodes
var soul: SoulMaster = null
var tip: TipMaster = null
var camera: Camera2D = null
var music: MusicMaster = null
var sound: SoundMaster = null
var screen_shake: ScreenShake = null
var mouse_cursor: MouseCursor = null
var black_mask: BlackMask = null
var effectlist_container: Control = null

# custom resource
var interpolation: Interpolation = null
var effect_library: EffectLibrary = null
var anim_library: AnimLibrary = null
# current dungeon
var cur_dungeon: AbstractDungeons = null


var effectlist: Array[AbstractGameEffect] = []
func _ready() -> void:
	# Initialize the game settings and player configuration
	initialize()
	load_resources()
	create_nodes()

	get_viewport().focus_entered.connect(_on_window_focus_in)
	get_viewport().focus_exited.connect(_on_window_focus_out)

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
	AbstractMonster.initialize()
	AbstractRelic.initialize()
	AbstractDungeons.initialize()

	MaterialLibrary.initialize()
	CardLibrary.initialize()
	RelicLibrary.initialize()
	CharacterManager.initialize()
	EventLibrary.initialize()
	
	# dungeons
	SceneLibrary.initialize()
	MainMenuScreen.initialize()
	DungeonMainScreen.initialize()

	
	if not Settings.seedSet:
		Settings.set_random_seed()


func _process(_delta: float) -> void:
	var i = effectlist.size() - 1
	while i >= 0:
		var effect = effectlist[i]
		if effect.is_done:
			effect.queue_free()
			effectlist.remove_at(i)
	
func exist_saved_game() -> bool:
	return false

func create_nodes() -> void:
	var screenSize = Vector2i(Settings.WIDTH, Settings.HEIGHT)

	soul = SoulMaster.new()
	soul.name = "SoulMaster"
	add_child(soul)

	tip = TipMaster.new()
	tip.name = "TipMaster"
	add_child(tip)

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
	effectlist_container = Control.new()
	effectlist_container.name = "EffectList Container"
	add_child(effectlist_container)
	effectlist_container.size = Vector2.ZERO
	effectlist_container.z_index = Global.EFFECT_Z_INDEX


func load_resources() -> void:
	interpolation = load("res://arts/resources/Interpolation.tres")
	effect_library = load("res://arts/resources/effect_library.tres")
	anim_library = load("res://arts/resources/anim_library.tres")

func disable_input(group_name: String) -> void:
	for node in get_tree().get_nodes_in_group(group_name):
		if node is Control:
			(node as Control).mouse_filter = Control.MOUSE_FILTER_IGNORE

func enable_input(group_name: String) -> void:
	for node in get_tree().get_nodes_in_group(group_name):
		if node is Control:
			(node as Control).mouse_filter = Control.MOUSE_FILTER_STOP

func disable_button_input() -> void:
	disable_input("buttons")

func enable_button_input() -> void:
	enable_input("buttons")

func load_new_dungeon(dungeon_prefab: PackedScene) -> void:
	var _dungeon_main_screen: DungeonMainScreen = dungeon_prefab.instantiate()
	get_parent().add_child(_dungeon_main_screen)

	CardGame.dungeon_main_screen = _dungeon_main_screen
	CardGame.dungeon_main_screen.load_new_dungeon(Exordium.ID, IronClad.ID, 0)

func load_next_dungeon() -> void:
	if CardGame.dungeon_main_screen == null:
		print("wtf... no dungeon main screen")
		return
	
	if CardGame.dungeon_main_screen.dungeon.id == Exordium.ID:
		CardGame.dungeon_main_screen.load_next_dungeon(TheCity.ID)
	elif CardGame.dungeon_main_screen.dungeon.id == TheCity.ID:
		CardGame.dungeon_main_screen.load_next_dungeon(TheBeyond.ID)
	elif CardGame.dungeon_main_screen.dungeon.id == TheBeyond.ID:
		CardGame.dungeon_main_screen.load_next_dungeon(TheEnding.ID)
	
	return

func add_game_effect(game_effect: AbstractGameEffect) -> void:
	effectlist_container.add_child(game_effect)
	effectlist.append(game_effect)

func _on_window_focus_in() -> void:
	is_focused = true

func _on_window_focus_out() -> void:
	is_focused = false
