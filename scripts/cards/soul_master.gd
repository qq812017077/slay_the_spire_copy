class_name SoulMaster
extends Control

const DEFAULT_SOUL_CACHE = 20
var idle_soul_pool: Array[Soul] = []
var working_souls: Array[Soul] = []

func _ready() -> void:
	for i in range(DEFAULT_SOUL_CACHE):
		var soul = Soul.new()
		idle_soul_pool.append(soul)

func _process(_delta: float) -> void:
	var end_souls: Array = working_souls.filter(Soul.is_idle_soul)
	
	for soul in end_souls:
		recycle_soul(soul)
	
func obtain_card(card: CardWidget) -> void:
	CardGame.sound.single_play("CARD_OBTAIN")
	card.enable_card_tip = false
	var soul: Soul = allocate_soul()
	soul.obtain(card)

func recycle_soul(soul: Soul) -> void:
	working_souls.erase(soul)
	idle_soul_pool.append(soul)
	remove_child(soul)

func allocate_soul() -> Soul:
	var soul: Soul = get_idle_soul()
	working_souls.append(soul)
	add_child(soul)
	return soul

func get_idle_soul() -> Soul:
	var soul: Soul = null
	if idle_soul_pool.size() == 0:
		soul = Soul.new()
		add_child(soul)
	else:
		soul = idle_soul_pool.pop_back()
	return soul
