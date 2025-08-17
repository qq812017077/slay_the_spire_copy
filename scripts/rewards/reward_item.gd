class_name RewardItem
extends Object

enum RewardType {
    CARD, GOLD, RELIC, POTION, STOLEN_GOLD, EMERALD_KEY, SAPPHIRE_KEY
}

var type: RewardType = RewardType.CARD
var cards: Array[AbstractCard] = []
var gold_amount: int = 0
var potion: AbstractPotion = null
var relic: AbstractRelic = null

func get_gold() -> int:
    return gold_amount