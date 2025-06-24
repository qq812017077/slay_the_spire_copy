##
##	脚本描述：存放卡牌的容器。
##		该容器可以包含多个卡牌，并且可以启用拖放区域功能。
##		如果启用拖放区域功能，则可以在容器内拖放卡牌。	
##		容器可以自动创建一个名为 "Cards" 的子节点来存放卡牌。
##	脚本功能：
##		1. 管理卡牌容器的创建和删除。
##		2. 管理卡牌的添加和删除。
##	作者：
##	创建时间：2024-01-01
##	版本：1.0
##	更新记录：
##		1.0 - 初始版本
##
class_name CardContainer extends Control

static var next_id = 0

@export_group("drop_zone")
## Enables or disables the drop zone functionality.
@export var enable_drop_zone := true

@export_subgroup("Sensor")
## The size of the sensor. If not set, it will follow the size of the card.
@export var sensor_size: Vector2
## The position of the sensor.
@export var sensor_position: Vector2
## The texture used for the sensor.
@export var sensor_texture: Texture
## Determines whether the sensor is visible or not.
@export var sensor_visibility := true


var unique_id: int
@onready var drop_zone_scene: PackedScene = preload("res://scenes/drop_zone.tscn")
var drop_zone : DropZone         = null
var _holding_cards : Array[CardWidget]= []

var card_manager: CardManager = null
var cards_node: Control = null

func _init():
	unique_id = next_id
	next_id += 1
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("CardContainer ready")
	cards_node = _try_get_cards_node()
	card_manager = _try_get_card_manager()

	if card_manager == null:
		push_error("CardContainer should be under the CardManager")
		return
	
	card_manager.add_card_container(unique_id, self)
	if enable_drop_zone:
		drop_zone = drop_zone_scene.instantiate()
		add_child(drop_zone)
		drop_zone.parent_card_container = self
		
		# If sensor_size is not set, they will follow the card size.
		if sensor_size == Vector2(0, 0):
			sensor_size = card_manager.card_size
		
		drop_zone.set_sensor(sensor_size, sensor_position, sensor_texture, sensor_visibility)

func _exit_tree() -> void:
	if card_manager != null:
		card_manager.delete_card_container(unique_id)

func add_card(card: CardWidget) -> void:
	CardUtils.move_object(card, cards_node)

func remove_card(card: CardWidget) -> bool:
	var index = _holding_cards.find(card)
	if index != -1:
		_holding_cards.remove_at(index)
	else:
		return false
	update_card_ui()
	return true

func clear_cards():
	for card in _holding_cards:
		CardUtils.remove_object(card)
	_holding_cards.clear()
	
func update_card_ui():
	# update cards position
	print("Updating card UI for container %s" % unique_id)

	
func _try_get_cards_node() -> Control:
	if has_node("Cards"):
		return $Cards
		
	var new_cards_node = Control.new()
	new_cards_node.name = "Cards"
	new_cards_node.mouse_filter = Control.MOUSE_FILTER_STOP
	add_child(new_cards_node)
	return new_cards_node

	
func _try_get_card_manager() -> CardManager:
	var cur: Node = get_parent()
	while cur != null and cur is not CardManager:
		cur = cur.get_parent()
	
	return cur
