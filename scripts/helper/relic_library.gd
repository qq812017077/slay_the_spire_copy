class_name RelicLibrary
extends Node


static var totalRelicCount: int = 0;
static var seenRelics: int = 0;

static var sharedRelics: Dictionary = {}
static var redRelics: Dictionary = {}
static var greenRelics: Dictionary = {}
static var blueRelics: Dictionary = {}
static var purpleRelics: Dictionary = {}


static var starterList: Array = []
static var commonList: Array = []
static var uncommonList: Array = []
static var rareList: Array = []
static var bossList: Array = []
static var specialList: Array = []
static var shopList: Array = []
static var redList: Array = []
static var greenList: Array = []
static var blueList: Array = []
static var purpleList: Array = []


static func initialize() -> void:
    add_shared_relics()
    add_red_relics()
    add_green_relics()
    add_blue_relics()
    add_purple_relics()


static func add_shared_relics() -> void:
    pass
static func add_red_relics() -> void:
    addRed(BurningBlood.new())
static func add_green_relics() -> void:
    addGreen(RingOfTheSnake.new())
static func add_blue_relics() -> void:
    addBlue(CrackedCore.new())
static func add_purple_relics() -> void:
    addPurple(PureWater.new())

static func add(relic: AbstractRelic) -> void:
    sharedRelics.set(relic.relicId, relic)
    add_to_tier_list(relic)
    totalRelicCount += 1

static func addRed(relic: AbstractRelic) -> void:
    redRelics.set(relic.relicId, relic)
    add_to_tier_list(relic)
    totalRelicCount += 1
    redList.append(relic)

static func addGreen(relic: AbstractRelic) -> void:
    greenRelics.set(relic.relicId, relic)
    add_to_tier_list(relic)
    totalRelicCount += 1
    greenList.append(relic)

static func addBlue(relic: AbstractRelic) -> void:
    blueRelics.set(relic.relicId, relic)
    add_to_tier_list(relic)
    totalRelicCount += 1
    blueList.append(relic)

static func addPurple(relic: AbstractRelic) -> void:
    purpleRelics.set(relic.relicId, relic)
    add_to_tier_list(relic)
    totalRelicCount += 1
    purpleList.append(relic)

static func add_to_tier_list(relic: AbstractRelic) -> void:
    match relic.tier:
        AbstractRelic.RelicTier.DEPRECATED:
            print(relic.relicId," is deprecated.")
        AbstractRelic.RelicTier.STARTER:
            starterList.append(relic)
        AbstractRelic.RelicTier.COMMON:
            commonList.append(relic)
        AbstractRelic.RelicTier.UNCOMMON:
            uncommonList.append(relic)
        AbstractRelic.RelicTier.RARE:
            rareList.append(relic)
        AbstractRelic.RelicTier.SPECIAL:
            specialList.append(relic)
        AbstractRelic.RelicTier.BOSS:
            bossList.append(relic)
        AbstractRelic.RelicTier.SHOP:
            shopList.append(relic)
        _:
            print(relic.relicId," is undefined.")

static func get_relic(key: String) -> AbstractRelic:
    if sharedRelics.has(key):
        return sharedRelics[key]
    if redRelics.has(key):
        return redRelics[key]
    if greenRelics.has(key):
        return greenRelics[key]
    if blueRelics.has(key):
        return blueRelics[key]
    if purpleRelics.has(key):
        return purpleRelics[key]
    return Circlet.new()