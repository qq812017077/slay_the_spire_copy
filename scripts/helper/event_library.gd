class_name EventLibrary
extends Object

enum RoomResult {EVENT, ELITE, TREASURE, SHOP, MONSTER}
const INIT_ELITE_CHANCE = 0.1
const INIT_MONSTER_CHANCE = 0.1
const INIT_SHOP_CHANCE = 0.03
const INIT_TREASURE_CHANCE = 0.02

static var elite_chance = 0.1
static var monster_chance = 0.1
static var shop_chance = 0.03
static var treasure_chance = 0.02

static var possible_results: Array[RoomResult] = []
static var pre_chances_for_save: Array[float] = []

static var event_dict: Dictionary = {}

static func initialize() -> void:
    possible_results.resize(100)

    # exordium
    # event_dict.set(BigFish.ID, BigFish.new())

    # # shrine
    # event_dict.set(GoldShrine.ID, GoldShrine.new())

static func get_chances() -> Array[float]:
    var chances: Array[float] = []
    chances.append(elite_chance)
    chances.append(monster_chance)
    chances.append(shop_chance)
    chances.append(treasure_chance)
    return chances

static func get_event(key: String) -> AbstractEvent:
    match key:
        BigFish.ID:
            return BigFish.new()
        GoldShrine.ID:
            return GoldShrine.new()
    return BigFish.new()

static func get_default_event() -> AbstractEvent:
    return BigFish.new()
    
static func roll(eventRng: RandomNumberGenerator) -> RoomResult:
    var roll_value: float = eventRng.randf()

    refresh()
    var choice: RoomResult = possible_results[int(roll_value * 100)]
    if choice == RoomResult.ELITE:
        elite_chance = 0.0
    else:
        elite_chance += 0.1
    
    if choice == RoomResult.MONSTER:
        monster_chance = 0.0
    else:
        monster_chance += 0.1
    
    if choice == RoomResult.SHOP:
        shop_chance = 0.0
    else:
        shop_chance += 0.03
    
    if choice == RoomResult.TREASURE:
        treasure_chance = 0.0
    else:
        treasure_chance += 0.02
    
    return choice


static func refresh() -> void:
    pre_chances_for_save = get_chances()
    var elite_size: int = 0
    if CardGame.dungeon_main_screen.floor_num < 6:
        elite_size = 0
    var monster_size: int = int(monster_chance * 100)
    var shop_size: int = int(shop_chance * 100)
    var treasure_size: int = int(treasure_chance * 100)

    possible_results.fill(RoomResult.EVENT)

    var fill_index: int = 0
    for i in range(min(99, fill_index), min(100, fill_index + elite_size)):
        possible_results[i] = RoomResult.ELITE
    fill_index += elite_size
    for i in range(min(99, fill_index), min(100, fill_index + monster_size)):
        possible_results[i] = RoomResult.MONSTER
    fill_index += monster_size
    for i in range(min(99, fill_index), min(100, fill_index + shop_size)):
        possible_results[i] = RoomResult.SHOP
    fill_index += shop_size
    for i in range(min(99, fill_index), min(100, fill_index + treasure_size)):
        possible_results[i] = RoomResult.TREASURE