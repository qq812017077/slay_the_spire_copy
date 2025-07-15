class_name AbstractDungeons
extends Object


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


var boss_list: Array[String] = []
var map: Array[Array] = []
var boss_room_node: MapRoomNode = null
var init_map_node: MapRoomNode = null
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

func generate_seeds() -> void:
	mapRng = RandomNumberGenerator.new()
	mapRng.seed = Settings.game_seed
	monsterRng = RandomNumberGenerator.new()
	monsterRng.seed = Settings.game_seed + 1
	eventRng = RandomNumberGenerator.new()
	eventRng.seed = Settings.game_seed + 2
	merchantRng = RandomNumberGenerator.new()
	merchantRng.seed = Settings.game_seed + 3
	cardRng = RandomNumberGenerator.new()
	cardRng.seed = Settings.game_seed + 4
	treasureRng = RandomNumberGenerator.new()
	treasureRng.seed = Settings.game_seed + 5
	relicRng = RandomNumberGenerator.new()
	relicRng.seed = Settings.game_seed + 6
	potionRng = RandomNumberGenerator.new()
	potionRng.seed = Settings.game_seed + 7
	monsterHpRng = RandomNumberGenerator.new()
	monsterHpRng.seed = Settings.game_seed + 8
	aiRng = RandomNumberGenerator.new()
	aiRng.seed = Settings.game_seed + 9

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
