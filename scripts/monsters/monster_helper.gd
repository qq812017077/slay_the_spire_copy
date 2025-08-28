class_name MonsterHelper
extends Object

# level1
static var LEVEL1_WEAK_Cultist: String = "Clutist"
static var LEVEL1_WEAK_Jaw_Worm: String = "Jaw Worm"
static var LEVEL1_WEAK_2_Louse: String = "2 Louse"
static var LEVEL1_WEAK_Small_Slimes: String = "Small Slimes"
static var LEVEL1_STRONG_Blue_Slaver: String = "Blue Slaver"
static var LEVEL1_STRONG_Gremlin_Gang: String = "Gremlin Gang"
static var LEVEL1_STRONG_Looter: String = "Looter"
static var LEVEL1_STRONG_Large_Slime: String = "Large Slime"
static var LEVEL1_STRONG_Lots_of_Slimes: String = "Lots of Slimes"
static var LEVEL1_STRONG_Exordium_Thugs: String = "Exordium Thugs"
static var LEVEL1_STRONG_Exordium_Wildlife: String = "Exordium Wildlife"
static var LEVEL1_STRONG_Red_Slaver: String = "Red Slaver"
static var LEVEL1_STRONG_3_Louse: String = "3 Louse"
static var LEVEL1_STRONG_2_Fungi_Beasts: String = "2 Fungi Beasts"

static var LEVEL1_ELITE_Gremlin_Bob: String = "Gremlin_Bob"
static var LEVEL1_ELITE_Lagavulin: String = "Lagavulin"
static var LEVEL1_ELITE_3_Sentries: String = "3 Sentries"

static var BOSS_LEVEL1_SLIME: String = "Slime Boss"
static var BOSS_LEVEL1_GUARDIAN: String = "The Guardian"
static var BOSS_LEVEL1_HEXAGHOST: String = "Hexaghost"


# level2
static var BOSS_LEVEL2_AUTOMATON: String = "Automaton"
static var BOSS_LEVEL2_COLLECTOR: String = "Collector"
static var BOSS_LEVEL2_CHAMP: String = "Champ"

# level3
static var BOSS_LEVEL3_AWAKENED_ONE: String = "Awakened One"
static var BOSS_LEVEL3_TIME_EATER: String = "Time Eater"
static var BOSS_LEVEL3_DONU_AND_DECA: String = "Donu and Deca"

static var BOSS_LEVEL_END_HEART: String = "The Heart"


static func normalize_weights(list: Array[MonsterInfo]) -> Array[MonsterInfo]:
    var total_weights : float = list.reduce(
        func (accum: float, m_info: MonsterInfo) -> float : 
            return accum + m_info.weight,
    0)

    var i: = list.size()-1
    while i >= 0:
        list[i].weight /= total_weights
    return list


static func roll(list: Array[MonsterInfo], roll_value : float) -> String:
    var cur_weight: float = 0.0
    for m: MonsterInfo in list:
        cur_weight += m.weight
        if roll_value < cur_weight:
            return m.name
    
    return "ERROR"