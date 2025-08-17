class_name AbstractScene
extends Control


var bg_overlay_color: Color = Color(0, 0, 0, 0.0)
var bg_overlay_target: float = 0.0


@export var bg_sprite: Sprite2D = null
@export var campfire_bg_sprite: Sprite2D = null
@export var camfire_glow_sprite: Sprite2D = null
@export var camfire_kindling_sprite: Sprite2D = null
@export var event_sprite: Sprite2D = null

var atlas: TextureAtlas = null
var bg: AtlasRegion = null

var campfire_bg: AtlasRegion = null
var campfire_glow: AtlasRegion = null
var campfire_kindling: AtlasRegion = null
var event: AtlasRegion = null

var ambiance_name: String = ""

var rooms: Array = []
func _init(atlas_url: String) -> void:
	atlas = TextureAtlas.load(atlas_url)
	bg = atlas.find_region("bg")
	campfire_bg = atlas.find_region("campfire")
	campfire_glow = atlas.find_region("mod/campfireGlow")
	campfire_kindling = atlas.find_region("mod/campfireKindling")
	event = atlas.find_region("event")


@onready var combat_room: Control = $CombatRoom
@onready var campfire_room: Control = $CampfireRoom
@onready var event_room: Control = $EventRoom

func _process(_delta: float) -> void:
	if campfire_room.visible:
		var alpha: float = cos(deg_to_rad(int(Time.get_ticks_msec() / 3.0) % 360)) * 0.1 + 0.8
		camfire_glow_sprite.self_modulate.a = alpha

func load_scene() -> void:
	if campfire_bg_sprite == null:
		campfire_bg_sprite = Sprite2D.new()
		campfire_room.add_child(campfire_bg_sprite)
		campfire_bg_sprite.name = "campfire_bg_sprite"
	set_texture(campfire_bg_sprite, campfire_bg)
	if camfire_glow_sprite == null:
		camfire_glow_sprite = Sprite2D.new()
		campfire_room.add_child(camfire_glow_sprite)
		camfire_glow_sprite.name = "camfire_glow_sprite"
	set_texture(camfire_glow_sprite, campfire_glow)
	if camfire_kindling_sprite == null:
		camfire_kindling_sprite = Sprite2D.new()
		campfire_room.add_child(camfire_kindling_sprite)
		camfire_kindling_sprite.name = "camfire_kindling_sprite"
	set_texture(camfire_kindling_sprite, campfire_kindling)

	if event_sprite == null:
		event_sprite = Sprite2D.new()
		event_room.add_child(event_sprite)
		event_room.move_child(event_sprite, 0)
		event_sprite.name = "event_sprite"
	set_texture(event_sprite, event)

	if bg_sprite == null:
		bg_sprite = Sprite2D.new()
		combat_room.add_child(bg_sprite)
		combat_room.move_child(bg_sprite, 0)
		combat_room.name = "bg_sprite"
	set_texture(bg_sprite, bg)

func open_combat_room() -> void:
	for room: Control in rooms:
		room.visible = true if room == combat_room else false

func open_campfire_room() -> void:
	for room: Control in rooms:
		room.visible = true if room == campfire_room else false


func open_event_room() -> void:
	for room: Control in rooms:
		room.visible = true if room == event_room else false
	
func refresh_scene() -> void:
	randomize_scene(RandomNumberGenerator.new())

func close_effects() -> void:
	pass
	
func show_effects() -> void:
	pass

func hide_effects() -> void:
	pass

func randomize_scene(_rng: RandomNumberGenerator) -> void:
	pass


static func set_texture(sprite: Sprite2D, region: AtlasRegion) -> void:
	sprite.texture = TextureHelper.get_cached_texture(region)
	sprite.centered = false
	sprite.offset = Vector2(region.offset.x, 1080 - region.offset.y - region.size.y)
	sprite.position = Vector2(0, 0)
#########################################################################
# Static functions
#########################################################################
static func initialize():
	pass
