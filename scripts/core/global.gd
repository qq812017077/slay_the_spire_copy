extends Node

enum CardColor {RED, GREEN, BLUE, PURPLE, COLORLESS, CURSE}
enum CardRarity {BASIC, SPECIAL, COMMON, UNCOMMON, RARE, CURSE}
enum CardTarget {NONE, ENEMY, SELF, ALL_ENEMIES, SELF_AND_ENEMY, ALL}
enum CardType {ATTACK, SKILL, POWER, STATUS, CURSE}
enum CardTag {HEALING, STRIKE, EMPTY, STARTER_DEFEND, STARTER_STRIKE}


const EPLISON: float = 0.00005


# layer
const TAB_Z_INDEX = 1

const SETTINGS_INDEX = 5

const TIP_Z_INDEX = 10

const SINGLE_POPUP_Z_INDEX = 15

const BLACKMASK_Z_INDEX = 30


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