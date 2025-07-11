@tool
class_name CardWidget
extends Control

const Z_INDEX_OFFSET_WHEN_HOLDING = 1000

enum ECardState {WAITED, HOVERING, HOLDING, MOVING_TO_DESTINATION}
enum CardMode {NORMAL, BIG}
# cached pool
static var attack_prefab: PackedScene = null
static var skill_prefab: PackedScene = null
static var power_prefab: PackedScene = null
static var attack_large_prefab: PackedScene = null
static var skill_large_prefab: PackedScene = null
static var power_large_prefab: PackedScene = null
static var attack_widgets_pool: Array[CardWidget] = []
static var skill_widgets_pool: Array[CardWidget] = []
static var power_widgets_pool: Array[CardWidget] = []

# cached textures
static var cached_background_textures_by_region: Dictionary = {}
static var cached_portrait_textures_by_region: Dictionary = {}
static var cached_frame_textures_by_region: Dictionary = {}
static var cached_banner_textures_by_region: Dictionary = {}
static var cached_orb_textures_by_region: Dictionary = {}
# variables
static var hovering_card_count: int = 0
static var RATIO: float = 230.0 / 322.0

@export var card_mode: CardMode = CardMode.NORMAL

@export var card_container: Control = null
@export var card_tooltip_prefab: PackedScene = null
## The speed at which the card moves.
@export var moving_speed: int = 2000
## Whether the card can be interacted with.
@export var can_be_interacted_with: bool = true
## The distance the card hovers when interacted with.
@export var hover_distance: int = 10


@onready var card_bg: TextureRect = $MarginContainer/PanelContainer/BG_Texture
@onready var card_icon: Sprite2D = $MarginContainer/PanelContainer/VBoxContainer/Upper/IconPart/Control/Icon
@onready var card_frame: Sprite2D = $MarginContainer/PanelContainer/VBoxContainer/Upper/FramePart/Control/Frame
@onready var card_banner: Sprite2D = $MarginContainer/PanelContainer/VBoxContainer/Upper/BannerPart/Control/Banner
@onready var card_name_ui: Label = $MarginContainer/PanelContainer/VBoxContainer/Upper/BannerPart/Control/CardName
@onready var card_type_ui: Label = $MarginContainer/PanelContainer/VBoxContainer/Upper/FramePart/Control/CardType

@onready var card_desc_container: Control = $MarginContainer/PanelContainer/VBoxContainer/Lower
@onready var card_orb_ui: TextureRect = $MarginContainer/Control/CostOrb
@onready var card_cost_ui: Label = $MarginContainer/Control/Cost

var current_card_state: ECardState = ECardState.WAITED
var card: AbstractCard = null
var upgraded_card_library: AbstractCard = null

var use_rich_text = false
var card_description_richtextlabel: CardDescriptionRichTextLabel = null
var card_description_label: CardDescriptionLabel = null

var enable_card_tip = false

var on_card_clicked: Callable

static func _static_init() -> void:
	attack_prefab = load("res://scenes/slay_the_spire/cards/attack_card.tscn")
	skill_prefab = load("res://scenes/slay_the_spire/cards/skill_card.tscn")
	power_prefab = load("res://scenes/slay_the_spire/cards/power_card.tscn")
	attack_large_prefab = load("res://scenes/slay_the_spire/cards/attack_card_large.tscn")
	skill_large_prefab = load("res://scenes/slay_the_spire/cards/skill_card_large.tscn")
	power_large_prefab = load("res://scenes/slay_the_spire/cards/power_card_large.tscn")

func _init(vcard_mode: CardMode = CardMode.NORMAL) -> void:
	card_mode = vcard_mode
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		return

	connect("mouse_entered", _on_mouse_enter)
	connect("mouse_exited", _on_mouse_exit)
	connect("gui_input", _on_gui_input)
	
	mouse_filter = Control.MOUSE_FILTER_STOP
	CardHelper.set_mouse_filter_recursion(self, Control.MOUSE_FILTER_IGNORE)

	refresh_card_style()

func set_card_mode(_card_mode):
	card_mode = _card_mode
	refresh_card_style()
	
func refresh_card_style() -> void:
	var use_large = card_mode == CardMode.BIG
	ThemeHelper.apply_card_title_font_style(card_cost_ui, {
		"font_color": Color.WHITE,
		"font_size": 76 if use_large else 36,
		"outline_size": 38 if use_large else 18,
	})
	ThemeHelper.apply_card_title_font_style(card_name_ui, {
		"font_color": Color.WHITE,
		"font_size": 46 if use_large else 24,
		"outline_size": 15,
		"shadow_offset_x": 6 if use_large else 3,
		"shadow_offset_y": 6 if use_large else 3,
		"shadow_outline_size": 10
	})

	card_type_ui.add_theme_font_override("font", ThemeHelper.get_bold_font())
	
	for child in card_desc_container.get_children():
		card_desc_container.remove_child(child)
	if use_rich_text:
		card_description_richtextlabel = CardDescriptionRichTextLabel.new()
		card_description_richtextlabel.apply_style(use_large)
		card_desc_container.add_child(card_description_richtextlabel)
	else:
		card_description_label = CardDescriptionLabel.new()
		card_description_label.apply_style(use_large)
		card_description_label.set_anchors_preset(LayoutPreset.PRESET_FULL_RECT)
		card_desc_container.add_child(card_description_label)


func is_hovering() -> bool:
	return current_card_state == ECardState.HOVERING

func set_cardscale(card_scale: float) -> void:
	card_container.scale = Vector2(card_scale, card_scale)
	custom_minimum_size = card_container.size * card_scale
	pivot_offset = custom_minimum_size / 2


func load_card(_card: AbstractCard, _upgrade: bool = false) -> void:
	if _card == null:
		push_error("Card is null, cannot load.")
		return
	self.name = _card.name
	self.card = _card
	
	card_bg.texture = get_cached_background_texture(_card, card_mode)
	card_icon.texture = get_cached_portrait_texture(_card, card_mode)
	card_frame.texture = get_cached_frame_texture(_card, card_mode)
	card_banner.texture = get_cached_banner_texture(_card, card_mode)
	var orb_atlas = get_cached_orb_texture(_card.color, card_mode)
	card_orb_ui.texture = orb_atlas
	card_type_ui.text = _card.get_card_type()
	
	card_orb_ui.size = orb_atlas.region.size
	card_cost_ui.size = orb_atlas.region.size
	card_cost_ui.position = card_orb_ui.position

	display(self.card)
	
func display(vcard: AbstractCard) -> void:
	card_name_ui.self_modulate = ThemeHelper.GREEN_TEXT_COLOR if vcard.upgraded else Color.WHITE
	card_cost_ui.self_modulate = ThemeHelper.GREEN_TEXT_COLOR if vcard.upgraded_cost else Color.WHITE
	card_name_ui.text = vcard.name
	if vcard.cost >= 0:
		card_cost_ui.text = str(vcard.cost)
	elif vcard.cost == -1:
		card_cost_ui.text = "X"
	else:
		card_orb_ui.visible = false
		card_cost_ui.visible = false
		
	if use_rich_text:
		card_description_richtextlabel.load_card(vcard)
	else:
		card_description_label.load_card(vcard)

func display_in_library(upgrade: bool, refresh: bool = false) -> void:
	if upgrade:
		if refresh or upgraded_card_library == null:
			upgraded_card_library = card.make_copy()
			upgraded_card_library.upgrade()
		display(upgraded_card_library)
		return
	upgraded_card_library = null
	display(card)

'''
############ Event Methods ############
'''
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
	if enable_card_tip:
		CardGame.cardtip.render_tip(self)

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

	# print("card:", card.card_id, " [", card.name, "]")
	# print("keywords:", card.keywords)
	# if upgraded_card_library == null:
	# 	print("card:", card.card_id, " [", card.name, "]")
	# 	print("---	base_damage:", card.base_damage)
	# 	print("---	base_block:", card.base_block)
	# 	print("---	base_magic_number:", card.base_magic_number)
	# else:
	# 	print("card:", upgraded_card_library.card_id, " [", upgraded_card_library.name, "]")
	# 	print("---	base_damage:", upgraded_card_library.base_damage)
	# 	print("---	base_block:", upgraded_card_library.base_block)
	# 	print("---	base_magic_number:", upgraded_card_library.base_magic_number)

# func _make_custom_tooltip(for_text: String) -> Object:
# 	if card.keywords.size() == 0:
# 		return null
# 	print("make tooltip")
	
# 	var tip : CardTip = card_tooltip_prefab.instantiate()
# 	tip.keyword_desc.text = card.keywords[0]
# 	return tip

func _on_mouse_exit() -> void:
	if current_card_state == ECardState.HOLDING:
		return
	current_card_state = ECardState.WAITED
	
	if enable_card_tip:
		CardGame.cardtip.remove_tip_rendering()
	# print("is wating:", name)

func _handle_mouse_pressed() -> void:
	if on_card_clicked.is_valid():
		on_card_clicked.call(self)
	current_card_state = ECardState.HOLDING
	pass

func _handle_mouse_released() -> void:
	# print("Mouse released on card:", name)
	current_card_state = ECardState.WAITED
	pass
'''
############ Static Methods ############
'''
static func get_cached_background_texture(_card: AbstractCard, cardmode: CardMode = CardMode.NORMAL) -> AtlasTexture:
	if _card == null:
		push_error("Card is null, cannot get background texture.")
		return null
	var use_large = cardmode == CardMode.BIG
	var bg_texture: AtlasRegion = _card.get_card_bg(use_large)
	if cached_background_textures_by_region.has(bg_texture):
		return cached_background_textures_by_region[bg_texture]
	
	# generate atlas texture
	var bg_atlas_texture: AtlasTexture = AtlasTexture.new()
	bg_atlas_texture.atlas = bg_texture.texture
	bg_atlas_texture.region = Rect2(bg_texture.xy, bg_texture.size)
	bg_atlas_texture.filter_clip = true
	cached_background_textures_by_region.set(bg_texture, bg_atlas_texture)
	return bg_atlas_texture

static func get_cached_portrait_texture(_card: AbstractCard, cardmode: CardMode = CardMode.NORMAL) -> AtlasTexture:
	if _card == null:
		push_error("Card is null, cannot get background texture.")
		return null
	var use_large = cardmode == CardMode.BIG
	if use_large:
		return ImageMaster.loadPortraitImg(_card.img_url)
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

static func get_cached_frame_texture(_card: AbstractCard, cardmode: CardMode = CardMode.NORMAL) -> AtlasTexture:
	if _card == null:
		push_error("Card is null, cannot get frame texture.")
		return null
	
	var use_large = cardmode == CardMode.BIG
	var frame_texture: AtlasRegion = _card.get_portrait_frame(use_large)
	if cached_frame_textures_by_region.has(frame_texture):
		return cached_frame_textures_by_region[frame_texture]

	# generate atlas texture
	var frame_atlas_texture: AtlasTexture = AtlasTexture.new()
	frame_atlas_texture.atlas = frame_texture.texture
	frame_atlas_texture.region = Rect2(frame_texture.xy, frame_texture.size)
	frame_atlas_texture.filter_clip = true
	cached_frame_textures_by_region.set(frame_texture, frame_atlas_texture)
	return frame_atlas_texture

static func get_cached_banner_texture(_card: AbstractCard, cardmode: CardMode = CardMode.NORMAL) -> AtlasTexture:
	if _card == null:
		push_error("Card is null, cannot get banner texture.")
		return null

	var use_large = cardmode == CardMode.BIG
	var banner_texture: AtlasRegion = _card.get_banner_image(use_large)
	if cached_banner_textures_by_region.has(banner_texture):
		return cached_banner_textures_by_region[banner_texture]

	# generate atlas texture
	var banner_atlas_texture: AtlasTexture = AtlasTexture.new()
	banner_atlas_texture.atlas = banner_texture.texture
	banner_atlas_texture.region = Rect2(banner_texture.xy, banner_texture.size)
	banner_atlas_texture.filter_clip = true
	cached_banner_textures_by_region.set(banner_texture, banner_atlas_texture)
	return banner_atlas_texture

static func get_cached_orb_texture(color: AbstractCard.CardColor, cardmode: CardMode = CardMode.NORMAL) -> AtlasTexture:
	var use_large = cardmode == CardMode.BIG
	var card_orb_texture: AtlasRegion = AbstractCard.get_card_cost_orb(color, use_large)
	if card_orb_texture == null:
		return null
	if cached_orb_textures_by_region.has(card_orb_texture):
		return cached_orb_textures_by_region[card_orb_texture]
	var orb_atlas_texture: AtlasTexture = AtlasTexture.new()
	orb_atlas_texture.atlas = card_orb_texture.texture
	orb_atlas_texture.region = Rect2(card_orb_texture.xy, card_orb_texture.size)
	orb_atlas_texture.filter_clip = true
	cached_orb_textures_by_region.set(card_orb_texture, orb_atlas_texture)
	
	return orb_atlas_texture


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
	widget.get_parent().remove_child(widget)
	match widget.card.type:
		Global.CardType.ATTACK:
			attack_widgets_pool.append(widget)
		Global.CardType.POWER:
			power_widgets_pool.append(widget)
		_:
			skill_widgets_pool.append(widget)
	
	# for child in widget.card_desc_container.get_children():
	# 	widget.card_desc_container.remove_child(child)
	widget.process_mode = Node.PROCESS_MODE_DISABLED
	widget.hide()
