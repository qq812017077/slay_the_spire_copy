class_name DungeonMainScreen
extends Control

enum ScreenType {NONE, COMBAT, MASTER_DECK_VIEW, SETTINGS, INPUT_SETTINGS, GRID, MAP,
	FTUE, CHOOSE_ONE, HAND_SELECT, SHOP, COMBAT_REWARD, DISCARD_VIEW,
	EXHAUST_VIEW, GAME_DECK_VIEW, BOSS_REWARD, DEATH, CARD_REWARD,
	TRANSFORM, VICTORY, UNLOCK, DOOR_UNLOCK, CREDITS, NO_INTERACT, NEOW_UNLOCK}

const MAP_HEIGHT = 15
const MAP_WIDTH = 7
const MAP_DENSITY = 6
const FINAL_ACT_MAP_HEIGHT = 3
var dungeon: AbstractDungeons

var cur_screen: ScreenType = ScreenType.NONE
var pre_screen: ScreenType = ScreenType.NONE

@export var dungeon_map_screen: DungeonMapScreen = null
@export var dungeon_transition_screen: DungeonTransitionScreen = null

static func initialize():
	DungeonMapScreen.initialize()
	DungeonTransitionScreen.initialize()
	Legend.initialize()

func _ready() -> void:
	CardGame.dungeon_main_screen = self
	
	load_dungeon(Exordium.ID)

func load_dungeon(dungeon_id: String) -> void:
	if dungeon_id == Exordium.ID:
		dungeon = Exordium.new()
	elif dungeon_id == TheCity.ID:
		dungeon = TheCity.new()
	elif dungeon_id == TheBeyond.ID:
		dungeon = TheBeyond.new()
	elif dungeon_id == TheEnding.ID:
		dungeon = TheEnding.new()

	CardGame.cur_dungeon = dungeon

	if not CardGame.black_mask.is_fading and not CardGame.black_mask.is_black:
		CardGame.black_mask.fade_in(Callable(), true)
	# initialize
	dungeon_map_screen.load_map(dungeon)
	CardGame.music.change_bgm(dungeon.id)
	await get_tree().create_timer(1).timeout
	
	while CardGame.black_mask.is_fading:
		await get_tree().create_timer(0.5).timeout

	if CardGame.black_mask.is_black:
		CardGame.black_mask.fade_out()
	dungeon_map_screen.open(true)
	dungeon_transition_screen.open(CardGame.cur_dungeon.id)
	CardGame.enable_input("button")
	
	set_screen_type(ScreenType.MAP)
func set_screen_type(screen_type: ScreenType) -> void:
	pre_screen = cur_screen
	cur_screen = screen_type

func open_screen(screen_type: ScreenType, fade_in: bool = true) -> void:
	set_screen_type(screen_type)
