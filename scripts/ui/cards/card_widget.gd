@tool
class_name CardWidget
extends Control

const Z_INDEX_OFFSET_WHEN_HOLDING = 1000
const SELECT_SCALE: float = 0.75
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
static var HOVERING_SCALE: Vector2 = Vector2(1.3, 1.3)
static var NORMAL_SCALE: Vector2 = Vector2(1, 1)
static var RECOVERING_SCALE: Vector2 = Vector2(0.8, 0.8)

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
var card_shadow: TextureRect = null
var use_rich_text = false
var card_description_richtextlabel: CardDescriptionRichTextLabel = null
var card_description_label: CardDescriptionLabel = null

var target_pos: Vector2 = Vector2(0, 0)
var target_angle: float = 0.0
var target_scale: Vector2 = Vector2.ONE
var enable_card_tip = false
var hover_timer: float = 0.0

var on_card_just_hovered: Callable
var on_card_clicked: Callable


var refresh_state_once: bool = false
var refresh_state_timer: float = 0.0
var refresh_card_state_in_process: bool = false

var glow_effect_container: Control = null
var glow_border_effect: CardGlowBorderEffect
var is_glowing : bool = false

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

func _process(delta: float) -> void:
	
	if not is_visible_in_tree():
		return
	
	if refresh_card_state_in_process:
		refresh_card_state()
	elif refresh_state_once:
		refresh_state_timer -= delta
		if refresh_state_timer <= 0.0:
			refresh_card_state()
			refresh_state_once = false

	if hover_timer >= 0.0:
		hover_timer = max(0.0, hover_timer - delta)
	match current_card_state:
		ECardState.HOVERING:
			_process_hovering(delta)
		ECardState.HOLDING:
			_process_holding(delta)
		ECardState.MOVING_TO_DESTINATION:
			_process_moving_to_destination(delta)


func add_glow_border() -> void:
	# glow_effect_container = Control.new()
	# glow_effect_container.name = "GlowEffectContainer"
	# card_container.add_child(glow_effect_container)
	# card_container.move_child(glow_effect_container, 0)
	if glow_border_effect:
		glow_border_effect.stop(true, true)
		return 
	glow_border_effect = CardGame.effect_library.card_glow_border_effect_prefab.instantiate()
	# glow_effect_container.add_child(glow_border_effect)
	glow_border_effect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	glow_border_effect.load(self, Color.hex(0x30c8dcff))
	card_container.add_child(glow_border_effect)
	card_container.move_child(glow_border_effect, 0)
	
	await get_tree().process_frame
	glow_border_effect.update_effect_position()

func remove_glow_border() -> void:
	if not glow_border_effect:
		return 
	stop_glow()
	glow_border_effect.queue_free()
	glow_border_effect = null

func begin_glow() -> void:
	if glow_border_effect:
		glow_border_effect.play()

func stop_glow() -> void:
	if glow_border_effect:
		glow_border_effect.stop(true, true)

func update_position(delta: float) ->void:
	if Settings.FAST_MODE:
		position = MathHelper.vec2_lerp_snap(position, target_pos, delta * 6.0)

	position = MathHelper.vec2_lerp_snap(position, target_pos, delta * 6.0)

func update_angle(delta: float) ->void:
	if rotation_degrees != target_angle:
		rotation_degrees = MathHelper.lerp_snap(rotation_degrees, target_angle, delta * 12.0)

func update_scale(delta: float) -> void:
	if (scale - target_scale).length_squared() > Global.EPLISON:
		scale = MathHelper.vec2_lerp_snap(scale, target_scale, delta * 8.0)
	else:
		scale = target_scale
func update_hovering_logic() -> void:
	if is_hovering():
		target_scale = HOVERING_SCALE
		scale = HOVERING_SCALE
		z_index = 1
	else:
		target_scale = NORMAL_SCALE
		z_index = 0
		
func refresh_card_state() -> void:
	if not CardGame.is_focused:
		return
	print("refresh_card_state")
	var is_mouse_hovered: bool = Rect2(Vector2(), size).has_point(get_local_mouse_position())
	if current_card_state == ECardState.WAITED and is_mouse_hovered:
		set_card_hover()
	elif current_card_state == ECardState.HOVERING and not is_mouse_hovered:
		current_card_state = ECardState.WAITED

func refresh_card_state_once(delay_time: float) -> void:
	refresh_state_once = true
	refresh_state_timer = delay_time

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

func enable(refresh: bool = false) -> void:
	# push_error("enable card:", name)
	mouse_filter = Control.MOUSE_FILTER_STOP
	process_mode = Node.PROCESS_MODE_INHERIT
	current_card_state = ECardState.WAITED
	if refresh:
		refresh_card_state()

func disable() -> void:
	# push_error("disable card:", name)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	process_mode = Node.PROCESS_MODE_DISABLED

func is_hovering() -> bool:
	return current_card_state == ECardState.HOVERING

func set_cardscale(card_scale: float) -> void:
	card_container.scale = Vector2(card_scale, card_scale)
	custom_minimum_size = card_container.size * card_scale
	set_size(custom_minimum_size)
	pivot_offset = custom_minimum_size / 2
	


func load_card(_card: AbstractCard, _upgrade: bool = false, create_shadow: bool = false) -> void:
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

	
	if create_shadow:
		add_shadow()
	display(self.card)


func add_shadow(offset: Vector2 = Vector2(10, 10)) -> void:
	if card_shadow == null:
		card_shadow = card_bg.duplicate()
		card_shadow.name = "shadow"
		add_child(card_shadow)
		move_child(card_shadow, 0)
		card_shadow.scale = $MarginContainer.scale
		card_shadow.modulate = Color(0, 0, 0, 0.3)
	card_shadow.texture = card_bg.texture
	card_shadow.visible = true
	card_shadow.position = offset

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


func get_center_position() -> Vector2:
	return position + size / 2

func get_global_center_position() -> Vector2:
	return global_position + size / 2

func set_target_pos_x(pos_x: float , instant: bool = false):
	target_pos.x = pos_x
	if instant:
		position.x = pos_x

func set_target_pos_y(pos_y: float , instant: bool = false):
	target_pos.y = pos_y
	if instant:
		position.y = pos_y

func set_target_pos(pos:Vector2, instant: bool = false):
	target_pos = pos
	if instant:
		position = pos

func set_target_angle(angle: float, instant: bool = false) :
	target_angle = angle
	if instant:
		rotation_degrees = angle

func set_target_scale(_scale: float, instant: bool = false) :
	target_scale = Vector2(_scale, _scale)
	if instant:
		scale = target_scale

'''
############ Event Methods ############
'''

func _process_hovering(_delta: float) -> void:
	if enable_card_tip and hover_timer <= 0.01:
		CardGame.tip.render_tip_for_card(self)
	
func _process_holding(_delta: float) -> void:
	pass
	
func _process_moving_to_destination(_delta: float) -> void:
	pass

func _on_gui_input(event: InputEvent) -> void:
	if not can_be_interacted_with:
		return

	if event is InputEventMouseButton:
		var mouse_event: InputEventMouseButton = event as InputEventMouseButton
		if mouse_event.button_index != MOUSE_BUTTON_LEFT and mouse_event.button_index != MOUSE_BUTTON_RIGHT:
			return

		if mouse_event.is_pressed():
			_handle_mouse_pressed(mouse_event.button_index)

		if mouse_event.is_released():
			_handle_mouse_released(mouse_event.button_index)


func _on_mouse_enter() -> void:
	if current_card_state == ECardState.HOLDING:
		return
	if not refresh_card_state_in_process:
		set_card_hover()

func _on_mouse_exit() -> void:
	if current_card_state == ECardState.HOLDING:
		return
	
	if not refresh_card_state_in_process:
		current_card_state = ECardState.WAITED
	if enable_card_tip:
		CardGame.tip.remove_tip_rendering()

func _handle_mouse_pressed(_mouse_button: MouseButton) -> void:
	# print("Mouse pressed on card:", name, "button:", mouse_button)
	if on_card_clicked.is_valid():
		on_card_clicked.call(self)
	# current_card_state = ECardState.HOLDING
	
func _handle_mouse_released(_mouse_button: MouseButton) -> void:
	# print("Mouse released on card:", name, "button:", mouse_button)
	# current_card_state = ECardState.WAITED
	pass

func set_card_waited() -> void:
	current_card_state = ECardState.WAITED

func set_card_hover() -> void:
	current_card_state = ECardState.HOVERING
	if on_card_just_hovered.is_valid():
		on_card_just_hovered.call(self)

'''
############ Event Methods ############
'''
func on_draw() -> void:
	card.on_draw()

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

static func allocate_by_type(card_type: AbstractCard.CardType, parent: Node = null, card_scale: float = 1.0) -> CardWidget:
	var widget: CardWidget
	match card_type:
		AbstractCard.CardType.ATTACK:
			if attack_widgets_pool.is_empty():
				widget = attack_prefab.instantiate() as CardWidget
			else:
				widget = attack_widgets_pool.pop_front()
		AbstractCard.CardType.POWER:
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
	
	widget.enable()
	widget.show()
	widget.modulate.a = 1.0
	widget.current_card_state = ECardState.WAITED
	widget.scale = Vector2.ONE
	if parent != null:
		parent.add_child(widget)
		widget.set_cardscale(Settings.scale * card_scale)
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


static func allocate(_card: AbstractCard, parent: Node, card_scale: float = 1.0) -> CardWidget:
	var widget: CardWidget = allocate_by_type(_card.type, parent, card_scale)
	widget.load_card(_card)
	return widget

static func recycle(widget: CardWidget) -> void:
	if widget == null:
		return
	# push_error("card {0}'s parent is {1}".format([widget.name, widget.get_parent()]))
	widget.get_parent().remove_child(widget)
	match widget.card.type:
		Global.CardType.ATTACK:
			attack_widgets_pool.append(widget)
		Global.CardType.POWER:
			power_widgets_pool.append(widget)
		_:
			skill_widgets_pool.append(widget)
	
	widget.on_card_clicked = Callable()
	widget.on_card_just_hovered = Callable()
	# for child in widget.card_desc_container.get_children():
	# 	widget.card_desc_container.remove_child(child)
	widget.enable_card_tip = false
	widget.rotation = 0
	widget.disable()
	widget.hide()
	widget.z_index = Global.CARD_Z_INDEX
	widget.refresh_card_state_in_process = false
	widget.remove_glow_border()

static func generate_cardwidgets(_cards: Array, parent: Node, card_scale: float = 1.0, create_shadow: bool = false) -> Array:
	var output: Array = []
	for cur_card in _cards:
		var card_widget = CardWidget.allocate_by_type(cur_card.type)
		card_widget.set_cardscale(Settings.scale * card_scale)
		parent.add_child(card_widget)
		output.append(card_widget)
		card_widget.load_card(cur_card, false, create_shadow)
	return output
