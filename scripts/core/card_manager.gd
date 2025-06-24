#
#	脚本功能：
#		Oversees all card-related nodes, manages card factories, and coordinates card creation, movement, and container relationships.
#
class_name CardManager
extends Control

@export_group("Card Settings")
## size of the card
@export var card_size : Vector2 = Vector2(150, 210)
## card image asset directory
@export var card_asset_dir: String
## card information json directory
@export var card_info_dir: String
## common back face image of cards
@export var back_image: Texture2D

@export_group("")
## card factory scene
@export var card_factory_scene: PackedScene

var card_factory: CardFactory
var card_container_dict : Dictionary = {}
var history := []

func _init() -> void:
	if Engine.is_editor_hint():
		return

func _ready() -> void:
	if not _pre_process_exported_variables():
		return
	if Engine.is_editor_hint():
		return
		
	# check card_factory scene is assigned
	if card_factory_scene == null:
		push_error("card_factory_scene is not assigned!")
		return
		
	if card_factory == null:
		push_error("card_factory is not initialized!")
		return 
		
	card_factory.card_size = card_size
	card_factory.card_asset_dir = card_asset_dir
	card_factory.card_info_dir = card_info_dir
	card_factory.back_image = back_image
	card_factory.preload_card_data()
	

func add_card_container(id:int, card_container: CardContainer) -> void:
	if id in card_container_dict:
		push_error("Card container with ID %d already exists!" % id)
		return
		
	card_container_dict[id] = card_container
	
	
func delete_card_container(id: int) -> void:
	if id not in card_container_dict:
		return
		
	card_container_dict.erase(id)

func _is_valid_directory(path: String) -> bool:
	var dir = DirAccess.open(path)
	return dir != null

func _pre_process_exported_variables() -> bool:
	if not _is_valid_directory(card_asset_dir):
		push_error("CardManager has invalid card_asset_dir")
		return false
	
	if not _is_valid_directory(card_info_dir):
		push_error("CardManager has invalid card_info_dir")
		return false

	if back_image == null:
		push_error("CardManager has no backface image assigned")
		
	if card_factory_scene == null:
		push_error("CardFactory is not assigned! Please set it in the CardManager Inspector.")
		return false
	
	var factory_instance = card_factory_scene.instantiate() as CardFactory
	if factory_instance == null:
		push_error("Failed to create an instance of CardFactory! CardManager imported an incorrect card factory scene.")
		return false

	add_child(factory_instance)
	card_factory = factory_instance
	return true
	
	
