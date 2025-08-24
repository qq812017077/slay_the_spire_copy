extends Node

enum CardColor {RED, GREEN, BLUE, PURPLE, COLORLESS, CURSE}
enum CardRarity {BASIC, SPECIAL, COMMON, UNCOMMON, RARE, CURSE}
enum CardTarget {NONE, ENEMY, SELF, ALL_ENEMIES, SELF_AND_ENEMY, ALL}
enum CardType {ATTACK, SKILL, POWER, STATUS, CURSE}
enum CardTag {HEALING, STRIKE, EMPTY, STARTER_DEFEND, STARTER_STRIKE}


const EPLISON: float = 0.00005


# layer
const BLACKBG_Z_INDEX = -10

const ROOM_Z_INDEX = -1

const CARD_Z_INDEX = 0
const DEFAULT_Z_INDEX = 0
# menu
const TAB_Z_INDEX = 1

const REWARD_FRONT_Z_INDEX = 1

const EFFECT_Z_INDEX = 3
const PARTICLE_EFFECT_Z_INDEX = 5
const SOUL_Z_INDEX = 6

# settings
const SETTINGS_INDEX = 7


# tip
const TIP_Z_INDEX = 10

# card popup
const SINGLE_POPUP_Z_INDEX = 15

# black screen transition
const BLACKMASK_Z_INDEX = 30

# overlay menu
const OVERLAY_BLACK_Z_INDEX = -1
const REWARD_SCREEN_Z_INDEX = 2

# group
const BUTTON_GROUP = "button"
const MAP_GROUP = "map"

func array_shuffle(rng: RandomNumberGenerator, array: Array):
    for i in array.size():
        var rand_idx = rng.randi_range(0, array.size() - 1)
        if rand_idx == i:
            pass
        else:
            var temp = array[rand_idx]
            array[rand_idx] = array[i]
            array[i] = temp
    return array