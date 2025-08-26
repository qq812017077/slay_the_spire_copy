class_name CardQueueItem
extends Object

var card: AbstractCard = null
var monster: AbstractMonster = null
var energy_on_use: int = 0

var ignore_energy_total: bool = false
var auto_play_card: bool = false
var random_target: bool = false
var is_end_turn_auto_play: bool = false


func _init(c: AbstractCard = null, m : AbstractMonster = null, 
    set_energy_on_use: int = 0, set_ignore_energy_total: bool = false, auto_play: bool = false) -> void:
    
    card = c
    monster = m
    energy_on_use = set_energy_on_use
    ignore_energy_total = set_ignore_energy_total
    auto_play_card = auto_play


static func create_item_without_monster(c: AbstractCard, set_is_end_turn_auto_play: bool):
    var item : CardQueueItem = CardQueueItem.new(c)
    item.is_end_turn_auto_play = set_is_end_turn_auto_play
    return item 