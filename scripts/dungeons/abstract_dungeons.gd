class_name AbstractDungeons
extends Object

const MONSTER_RNG_SEED_OFFSET = 1
const MAP_RNG_SEED_OFFSET = 2
const EVENT_RNG_SEED_OFFSET = 3
const MERCHANT_RNG_SEED_OFFSET = 4
const CARD_RNG_SEED_OFFSET = 5
const TREASURE_RNG_SEED_OFFSET = 6
const RELIC_RNG_SEED_OFFSET = 7
const POTION_RNG_SEED_OFFSET = 8
const MONSTER_HP_RNG_SEED_OFFSET = 9
const AI_RNG_SEED_OFFSET = 10
const SHUFFLE_RNG_SEED_OFFSET = 11
const CARD_RANDOM_RNG_SEED_OFFSET = 12
const MISC_RNG_SEED_OFFSET = 13

# random
var monsterRng: RandomNumberGenerator
var mapRng: RandomNumberGenerator
var eventRng: RandomNumberGenerator
var merchantRng: RandomNumberGenerator
var cardRng: RandomNumberGenerator
var treasureRng: RandomNumberGenerator
var relicRng: RandomNumberGenerator
var potionRng: RandomNumberGenerator
var monsterHpRng: RandomNumberGenerator
var aiRng: RandomNumberGenerator
var shuffleRng: RandomNumberGenerator
var cardRandomRng: RandomNumberGenerator
var miscRng: RandomNumberGenerator

var name: String
var level_num: String
var id: String
var player: AbstractPlayer
var transformedCard: AbstractCard
var eventBackgroundImg: TextureRect

var map: Array[Array] = []
var boss_room_node: MapRoomNode = null
var init_map_node: MapRoomNode = null
var cur_room_node: MapRoomNode = null

var monster_list: Array[String] = []
var elite_list: Array[String] = []
var boss_list: Array[String] = []
var event_list: Array[String] = []
var special_one_time_event_list: Array[String] = []
var shrine_list: Array[String] = []

# chance
var cardUpgradedChance: float
var colorlessRareChance: float
var shopRoomChance: float
var restRoomChance: float
var eventRoomChance: float
var eliteRoomChance: float
var treasureRoomChance: float

var smallChestChance: float
var mediumChestChance: float
var largeChestChance: float
var commonRelicChance: float
var uncommonRelicChance: float
var rareRelicChance: float

var shrineChance: float

# 
var fade_color: Color

static func initialize() -> void:
	Exordium.initialize()
	TheBeyond.initialize()
	TheCity.initialize()
	TheEnding.initialize()


func _init(_name: String, levelId: String, _player: AbstractPlayer, _event_list: Array[String]) -> void:
	name = _name
	id = levelId
	player = _player
	init_chances()
	generate_seeds()
	generate_enemies()
	
	init_boss()
	init_event_list()
	init_event_img()
	init_shrine_list()
	init_card_pool()
	init_potions()


func init_boss() -> void:
	pass
func init_event_list() -> void:
	pass
func init_event_img() -> void:
	pass
func init_shrine_list() -> void:
	pass
func init_card_pool() -> void:
	pass
func init_potions() -> void:
	pass


func init_chances() -> void:
	shopRoomChance = 0.05
	restRoomChance = 0.12
	treasureRoomChance = 0.0
	eventRoomChance = 0.22
	eliteRoomChance = 0.08
	smallChestChance = 50
	mediumChestChance = 33
	largeChestChance = 17
	commonRelicChance = 50
	uncommonRelicChance = 33
	rareRelicChance = 17
	colorlessRareChance = 0.3
	cardUpgradedChance = 0.0
	shrineChance = 0.25

func generate_seeds() -> void:
	mapRng = RandomNumberGenerator.new()
	mapRng.seed = Settings.game_seed + CardGame.dungeon_main_screen.floor_num
	monsterRng = RandomNumberGenerator.new()
	monsterRng.seed = Settings.game_seed + 1  + CardGame.dungeon_main_screen.floor_num
	eventRng = RandomNumberGenerator.new()
	eventRng.seed = Settings.game_seed + 2  + CardGame.dungeon_main_screen.floor_num
	merchantRng = RandomNumberGenerator.new()
	merchantRng.seed = Settings.game_seed + 3  + CardGame.dungeon_main_screen.floor_num
	cardRng = RandomNumberGenerator.new()
	cardRng.seed = Settings.game_seed + 4  + CardGame.dungeon_main_screen.floor_num
	treasureRng = RandomNumberGenerator.new()
	treasureRng.seed = Settings.game_seed + 5  + CardGame.dungeon_main_screen.floor_num
	relicRng = RandomNumberGenerator.new()
	relicRng.seed = Settings.game_seed + 6  + CardGame.dungeon_main_screen.floor_num
	potionRng = RandomNumberGenerator.new()
	potionRng.seed = Settings.game_seed + 7  + CardGame.dungeon_main_screen.floor_num
	monsterHpRng = RandomNumberGenerator.new()
	monsterHpRng.seed = Settings.game_seed + MONSTER_HP_RNG_SEED_OFFSET
	aiRng = RandomNumberGenerator.new()
	aiRng.seed = Settings.game_seed + AI_RNG_SEED_OFFSET
	shuffleRng = RandomNumberGenerator.new()
	shuffleRng.seed = Settings.game_seed + SHUFFLE_RNG_SEED_OFFSET
	cardRandomRng = RandomNumberGenerator.new()
	cardRandomRng.seed = Settings.game_seed + CARD_RANDOM_RNG_SEED_OFFSET
	miscRng = RandomNumberGenerator.new()
	miscRng.seed = Settings.game_seed + MISC_RNG_SEED_OFFSET

func refresh_rng(floor_num: int) -> void:
	monsterHpRng.seed = Settings.game_seed + floor_num + MONSTER_HP_RNG_SEED_OFFSET
	aiRng.seed = Settings.game_seed + floor_num + AI_RNG_SEED_OFFSET
	shuffleRng.seed = Settings.game_seed + floor_num + SHUFFLE_RNG_SEED_OFFSET
	cardRandomRng.seed = Settings.game_seed + floor_num + CARD_RANDOM_RNG_SEED_OFFSET
	miscRng.seed = Settings.game_seed + floor_num + MISC_RNG_SEED_OFFSET

func random_upgrade() -> bool:
	return randf() < cardUpgradedChance


func generate_event() -> AbstractEvent:
	var event_ret: AbstractEvent = null
	if eventRng.randf() >= shrineChance:
		event_ret = get_event()
		if event_ret == null:
			return get_shrine()
		return event_ret
	elif not shrine_list.is_empty() or not special_one_time_event_list.is_empty():
		return get_shrine()
	else:
		if event_list.is_empty():
			return null
		
		return get_event()

func get_event() -> AbstractEvent:
	var tmp = event_list.duplicate()
	if tmp.size() == 0:
		return get_shrine()
	
	var tmp_key: String = tmp[eventRng.randi_range(0, tmp.size() - 1)]
	event_list.erase(tmp_key)
	return EventLibrary.get_event(tmp_key)

func get_shrine() -> AbstractEvent:
	var tmp = shrine_list.duplicate()
	if tmp.size() == 0:
		return EventLibrary.get_default_event()
	var tmp_key: String = tmp[eventRng.randi_range(0, tmp.size() - 1)]
	shrine_list.erase(tmp_key)
	return EventLibrary.get_event(tmp_key)

func generate_enemies() -> void:
	pass
func get_shop_room_chance() -> float:
	return shopRoomChance
func get_rest_room_chance() -> float:
	return restRoomChance
func get_event_room_chance() -> float:
	return eventRoomChance
func get_treasure_room_chance() -> float:
	return treasureRoomChance

func get_elite_room_chance() -> float:
	return eliteRoomChance

func is_boss_room() -> bool:
	return cur_room_node != null and cur_room_node.room.type == AbstractRoom.RoomType.BOSS


static func generate_map(cur_dungeon: AbstractDungeons, generate_boss: bool = true) -> void:
	var starting_time: int = Time.get_ticks_msec()

	# height: 15, width: 7, density: 6
	var _map = MapGenerator.generate_dungeon(15, 7, 6, cur_dungeon.mapRng)
	
	var count: int = 0
	var height: int = _map.size()
	for row in _map:
		for node: MapRoomNode in row:
			if node.has_edges() and node.y != height - 2:
				count += 1
	var room_list = generate_room_type(cur_dungeon, count)

	
	if generate_boss:
		cur_dungeon.boss_room_node = MapRoomNode.new(3, 16)
		cur_dungeon.boss_room_node.set_room_by_type(AbstractRoom.RoomType.BOSS)

	# 最后一层设置为篝火
	for node: MapRoomNode in _map[height - 1]:
		node.set_room_by_type(AbstractRoom.RoomType.REST)
		if generate_boss and node.has_edges():
			cur_dungeon.boss_room_node.add_parent(node)
	
	# 第1层设置为怪物房
	for node: MapRoomNode in _map[0]:
		node.set_room_by_type(AbstractRoom.RoomType.MONSTER)
	# 第9层设置为宝藏
	for node: MapRoomNode in _map[8]:
		node.set_room_by_type(AbstractRoom.RoomType.TREASURE)
	
	RoomHelper.distribute_rooms_across_map(_map, room_list, cur_dungeon.mapRng)
	cur_dungeon.map = _map

	print("generate map time: ", Time.get_ticks_msec() - starting_time, "ms")

static func generate_room_type(cur_dungeon: AbstractDungeons, room_count: int) -> Array[AbstractRoom]:
	var room_list: Array[AbstractRoom] = []
	print("rooms count: ", room_count)
	var shop_count = round(room_count * cur_dungeon.get_shop_room_chance())
	var rest_count = round(room_count * cur_dungeon.get_rest_room_chance())
	var treasure_count = round(room_count * cur_dungeon.get_treasure_room_chance())

	var elite_count = round(room_count * cur_dungeon.get_elite_room_chance())
	
	var event_count = round(room_count * cur_dungeon.get_event_room_chance())
	var monster_count = room_count - shop_count - rest_count - treasure_count - elite_count - event_count
	print("display all count:")
	print("shop count: ", shop_count)
	print("rest count: ", rest_count)
	print("treasure count: ", treasure_count)
	print("elite count: ", elite_count)
	print("event count: ", event_count)
	print("monster count: ", monster_count)
	for i in range(shop_count):
		room_list.append(ShopRoom.new())
	for i in range(rest_count):
		room_list.append(RestRoom.new())
	for i in range(elite_count):
		room_list.append(EliteRoom.new())
	for i in range(event_count):
		room_list.append(EventRoom.new())
	
	return room_list
