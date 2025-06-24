@tool
class_name CardWidget
extends Control

const Z_INDEX_OFFSET_WHEN_HOLDING = 1000

enum ECardState { WAITED, HOVERING, HOLDING, MOVING_TO_DESTINATION }


# cached pool
static var attack_prefab: PackedScene = null
static var skill_prefab: PackedScene = null
static var power_prefab: PackedScene = null
static var attack_widgets_pool: Array[CardWidget] = []
static var skill_widgets_pool: Array[CardWidget] = []
static var power_widgets_pool: Array[CardWidget] = []

# cached textures
static var cached_background_textures_by_region: Dictionary = {}
static var cached_portrait_textures_by_region: Dictionary = {}
static var cached_frame_textures_by_region: Dictionary = {}
static var cached_banner_textures_by_region: Dictionary = {}
static var cached_orb_textures_by_region: Dictionary = {}
static var cached_desc_by_name: Dictionary = {}
# variables
static var hovering_card_count: int = 0
static var RATIO: float = 230.0 / 322.0

## The speed at which the card moves.
@export var moving_speed: int = 2000
## Whether the card can be interacted with.
@export var can_be_interacted_with: bool = true
## The distance the card hovers when interacted with.
@export var hover_distance: int = 10

#@onready var front_face_texture: TextureRect = $FrontFace/TextureRect
#@onready var back_face_texture: TextureRect = $BackFace/TextureRect
@onready var card_bg: TextureRect = $PanelContainer/BG_Texture
#@onready var card_icon: TextureRect = $PanelContainer/VBoxContainer/Upper/IconPart/HBoxContainer/Icon
@onready var card_icon: TextureRect = $PanelContainer/VBoxContainer/Upper/IconPart/Control/Icon
#@onready var card_frame: TextureRect = $PanelContainer/VBoxContainer/Upper/FramePart/HBoxContainer/Frame
@onready var card_frame: TextureRect = $PanelContainer/VBoxContainer/Upper/FramePart/Control/Frame
@onready var card_banner: TextureRect = $PanelContainer/VBoxContainer/Upper/BannerPart/Control/Banner
@onready var card_name_ui: Label = $PanelContainer/VBoxContainer/Upper/BannerPart/Control/CardName
#@onready var card_type_ui: Label = $PanelContainer/VBoxContainer/Upper/FramePart/HBoxContainer/Frame/CardType
@onready var card_type_ui: Label = $PanelContainer/VBoxContainer/Upper/FramePart/Control/CardType

@onready var card_desc_container: MarginContainer = $PanelContainer/VBoxContainer/Lower
@onready var card_orb_ui: TextureRect = $Control/CostOrb
@onready var card_cost_ui: Label = $Control/Cost

var current_card_state: ECardState = ECardState.WAITED
var card : AbstractCard = null

static func _static_init() -> void:
	attack_prefab = load("res://scenes/slay_the_spire/cards/attack_card.tscn")
	skill_prefab = load("res://scenes/slay_the_spire/cards/skill_card.tscn")
	power_prefab = load("res://scenes/slay_the_spire/cards/power_card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		return

	connect("mouse_entered", _on_mouse_enter)
	connect("mouse_exited", _on_mouse_exit)
	connect("gui_input", _on_gui_input)

	mouse_filter = Control.MOUSE_FILTER_STOP
	CardHelper.set_mouse_filter_recursion(self, Control.MOUSE_FILTER_IGNORE)

	card_name_ui.add_theme_font_override("font", ThemeHelper.get_card_title_font())
	card_type_ui.add_theme_font_override("font", ThemeHelper.get_card_type_font())


func _process(delta: float) -> void:
		
	# process card state
	match current_card_state:
		ECardState.HOVERING:
			_process_hovering(delta)
		ECardState.HOLDING:
			_process_holding(delta)
		ECardState.MOVING_TO_DESTINATION:
			_process_moving_to_destination(delta)

func _process_hovering(_delta: float) -> void:
	pass

func _process_holding(_delta: float) -> void:
	pass
	
func _process_moving_to_destination(_delta: float) -> void:
	pass

func _on_gui_input(event: InputEvent) -> void:
	if not can_be_interacted_with:
		return

	if event is InputEventMouseButton:
		var mouse_event: InputEventMouseButton = event as InputEventMouseButton
		if mouse_event.button_index != MOUSE_BUTTON_LEFT:
			return

		if mouse_event.is_pressed():
			_handle_mouse_pressed()

		if mouse_event.is_released():
			_handle_mouse_released()
		
		
func _on_mouse_enter() -> void:
	if current_card_state == ECardState.HOLDING:
		return 
	current_card_state = ECardState.HOVERING
	# print("is hoving:", name)
	
func _on_mouse_exit() -> void:
	if current_card_state == ECardState.HOLDING:
		return 
	current_card_state = ECardState.WAITED
	# print("is wating:", name)

func _handle_mouse_pressed() -> void:
	print("Mouse pressed on card:", name)
	# start holding the card
	current_card_state = ECardState.HOLDING
	pass
	
	
func _handle_mouse_released() -> void:
	print("Mouse released on card:", name)
	current_card_state = ECardState.WAITED
	pass

func is_hovering() -> bool:
	return current_card_state == ECardState.HOVERING
	
func load_card(_card: AbstractCard) -> void:
	if _card == null:
		push_error("Card is null, cannot load.")
		return
	self.name = _card.name
	self.card = _card

	card_bg.texture = get_cached_background_texture(_card)
	card_icon.texture = get_cached_portrait_texture(_card)
	card_frame.texture = get_cached_frame_texture(_card)
	card_banner.texture = get_cached_banner_texture(_card)
	card_orb_ui.texture = get_cached_orb_texture(_card.color)
	card_name_ui.text = _card.name
	card_type_ui.text = _card.get_card_type()
	if _card.cost >= 0:
		card_cost_ui.text = str(_card.cost) 
	elif _card.cost == -1:
		card_cost_ui.text = "X"
	else:
		card_orb_ui.visible = false
		card_cost_ui.visible = false
	
	if card_desc_container.has_node("Desc"):
		var desc_node: Node = card_desc_container.get_node("Desc")
		card_desc_container.remove_child(desc_node)
	var card_description_label: CardDescriptionLabel = _card.get_description_label()
	card_description_label.name = "Desc"
	card_desc_container.add_child(card_description_label)


static func get_cached_background_texture(_card: AbstractCard) -> AtlasTexture:
	if _card == null:
		push_error("Card is null, cannot get background texture.")
		return null
	
	var bg_texture: AtlasRegion = _card.get_card_bg()
	if cached_background_textures_by_region.has(bg_texture):
		return cached_background_textures_by_region[bg_texture]
	
	# generate atlas texture
	var bg_atlas_texture: AtlasTexture = AtlasTexture.new()
	bg_atlas_texture.atlas = bg_texture.texture
	bg_atlas_texture.region = Rect2(bg_texture.xy, bg_texture.size)
	bg_atlas_texture.filter_clip = true
	cached_background_textures_by_region.set(bg_texture, bg_atlas_texture)
	return bg_atlas_texture

static func get_cached_portrait_texture(_card: AbstractCard) -> AtlasTexture:
	if _card == null:
		push_error("Card is null, cannot get background texture.")
		return null

	var portrait_texture: AtlasRegion = _card.get_portrait()
	if cached_portrait_textures_by_region.has(portrait_texture):
		return cached_portrait_textures_by_region[portrait_texture]

	# generate atlas texture
	var portrait_atlas_texture: AtlasTexture = AtlasTexture.new()
	portrait_atlas_texture.atlas = portrait_texture.texture
	portrait_atlas_texture.region = Rect2(portrait_texture.xy, portrait_texture.size)
	portrait_atlas_texture.filter_clip = true
	cached_portrait_textures_by_region.set(portrait_texture, portrait_atlas_texture)
	return portrait_atlas_texture

static func get_cached_frame_texture(_card: AbstractCard) -> AtlasTexture:
	if _card == null:
		push_error("Card is null, cannot get frame texture.")
		return null

	var frame_texture: AtlasRegion = _card.get_portrait_frame()
	if cached_frame_textures_by_region.has(frame_texture):
		return cached_frame_textures_by_region[frame_texture]

	# generate atlas texture
	var frame_atlas_texture: AtlasTexture = AtlasTexture.new()
	frame_atlas_texture.atlas = frame_texture.texture
	frame_atlas_texture.region = Rect2(frame_texture.xy, frame_texture.size)
	frame_atlas_texture.filter_clip = true
	cached_frame_textures_by_region.set(frame_texture, frame_atlas_texture)
	return frame_atlas_texture

static func get_cached_banner_texture(_card: AbstractCard) -> AtlasTexture:
	if _card == null:
		push_error("Card is null, cannot get banner texture.")
		return null

	var banner_texture: AtlasRegion = _card.get_banner_image()
	if cached_banner_textures_by_region.has(banner_texture):
		return cached_banner_textures_by_region[banner_texture]

	# generate atlas texture
	var banner_atlas_texture: AtlasTexture = AtlasTexture.new()
	banner_atlas_texture.atlas = banner_texture.texture
	banner_atlas_texture.region = Rect2(banner_texture.xy, banner_texture.size)
	banner_atlas_texture.filter_clip = true
	cached_banner_textures_by_region.set(banner_texture, banner_atlas_texture)
	return banner_atlas_texture

static func get_cached_orb_texture(color: AbstractCard.CardColor) -> AtlasTexture:
	var card_cost_orb_texture : AtlasRegion = AbstractCard.get_card_cost_orb(color)
	if card_cost_orb_texture == null:
		return null
	if cached_orb_textures_by_region.has(card_cost_orb_texture):
		return cached_orb_textures_by_region[card_cost_orb_texture]
	var cost_orb_atlas_texture: AtlasTexture = AtlasTexture.new()
	cost_orb_atlas_texture.atlas = card_cost_orb_texture.texture
	cost_orb_atlas_texture.region = Rect2(card_cost_orb_texture.xy, card_cost_orb_texture.size)
	cost_orb_atlas_texture.filter_clip = true
	cached_orb_textures_by_region.set(card_cost_orb_texture, cost_orb_atlas_texture)
	
	return cost_orb_atlas_texture


static func allocate_by_type(card_type: Global.CardType) -> CardWidget:
	var widget: CardWidget
	match card_type:
		Global.CardType.ATTACK:
			if attack_widgets_pool.is_empty():
				widget = attack_prefab.instantiate() as CardWidget
			else:
				widget = attack_widgets_pool.pop_front()
		Global.CardType.POWER:
			if power_widgets_pool.is_empty():
				widget = power_prefab.instantiate() as CardWidget
			else:
				widget = power_widgets_pool.pop_front()
		_:
			if skill_widgets_pool.is_empty():
				widget = skill_prefab.instantiate() as CardWidget
			else:
				widget = skill_widgets_pool.pop_front()
	
	widget.process_mode = Node.PROCESS_MODE_INHERIT
	widget.show()
	return widget

static func preallocate() -> void:
	var widget: CardWidget
	for i in range(30):
		widget = attack_prefab.instantiate() as CardWidget
		attack_widgets_pool.append(widget)
		widget.process_mode = Node.PROCESS_MODE_DISABLED
		widget.hide()
	
	for i in range(30):
		widget = skill_prefab.instantiate() as CardWidget
		skill_widgets_pool.append(widget)
		widget.process_mode = Node.PROCESS_MODE_DISABLED
		widget.hide()

	for i in range(30):
		widget = power_prefab.instantiate() as CardWidget
		power_widgets_pool.append(widget)
		widget.process_mode = Node.PROCESS_MODE_DISABLED
		widget.hide()

static func allocate(_card: AbstractCard) -> CardWidget:
	var widget: CardWidget
	match _card.type:
		Global.CardType.ATTACK:
			if attack_widgets_pool.is_empty():
				widget = attack_prefab.instantiate() as CardWidget
			else:
				widget = attack_widgets_pool.pop_front()
		Global.CardType.POWER:
			if power_widgets_pool.is_empty():
				widget = power_prefab.instantiate() as CardWidget
			else:
				widget = power_widgets_pool.pop_front()
		_:
			if skill_widgets_pool.is_empty():
				widget = skill_prefab.instantiate() as CardWidget
			else:
				widget = skill_widgets_pool.pop_front()
	
	widget.process_mode = Node.PROCESS_MODE_INHERIT
	widget.show()
	widget.load_card(_card)
	return widget

static func recycle(widget: CardWidget) -> void:
	if widget == null:
		return 
	match widget.card.type:
		Global.CardType.ATTACK:
			attack_widgets_pool.append(widget)
		Global.CardType.POWER:
			power_widgets_pool.append(widget)
		_:
			skill_widgets_pool.append(widget)
	
	
	for child in widget.card_desc_container.get_children():
		widget.card_desc_container.remove_child(child)
	widget.process_mode = Node.PROCESS_MODE_DISABLED
	widget.hide()
