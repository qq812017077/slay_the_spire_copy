class_name BottomScene
extends AbstractScene

const ATLAS_PATH = "res://arts/slay_the_spire/scenes/bottomScene/scene.atlas"

static var torch_effect_pool: Array[InteractableTorchEffect] = []
@export_group("Combat/Background")
@export var mg_sprite: Sprite2D = null
@export var left_wall_sprite: Sprite2D = null
@export var hollow_wall_sprite: Sprite2D = null
@export var solid_wall_sprite: Sprite2D = null
@export var ceiling_sprite: Sprite2D = null
@export var ceilingMod1_sprite: Sprite2D = null
@export var ceilingMod2_sprite: Sprite2D = null
@export var ceilingMod3_sprite: Sprite2D = null
@export var ceilingMod4_sprite: Sprite2D = null
@export var ceilingMod5_sprite: Sprite2D = null
@export var ceilingMod6_sprite: Sprite2D = null
@export_group("")
@export_group("Combat/Effects")
@export var dust_effect: DustEffect = null
@export var fog_effect: FogEffect = null
@export var torch_container: Control = null
@export var torch_effect_prefab: PackedScene = null
@export_group("")


@export_group("Combat/Foreground")
@export var fg_sprite: Sprite2D = null
@export_group("")

@export_group("Combat/Config")
@export var draw_left_wall: bool = false
@export var draw_hollow_wall: bool = false
@export var draw_solid_wall: bool = false
@export var draw_ceilingMod1: bool = false
@export var draw_ceilingMod2: bool = false
@export var draw_ceilingMod3: bool = false
@export var draw_ceilingMod4: bool = false
@export var draw_ceilingMod5: bool = false
@export var draw_ceilingMod6: bool = false
@export_group("")


var fg: AtlasRegion = null
var mg: AtlasRegion = null
var left_wall: AtlasRegion = null
var hollow_wall: AtlasRegion = null
var solid_wall: AtlasRegion = null

var ceiling: AtlasRegion = null
var ceilingMod1: AtlasRegion = null
var ceilingMod2: AtlasRegion = null
var ceilingMod3: AtlasRegion = null
var ceilingMod4: AtlasRegion = null
var ceilingMod5: AtlasRegion = null
var ceilingMod6: AtlasRegion = null

var torches: Array[InteractableTorchEffect] = []

func _init() -> void:
	super (ATLAS_PATH)
	ambiance_name = "AMBIANCE_BOTTOM"
	
	fg = atlas.find_region("mod/fg")
	mg = atlas.find_region("mod/mg")
	left_wall = atlas.find_region("mod/mod1")
	hollow_wall = atlas.find_region("mod/mod2")
	solid_wall = atlas.find_region("mod/midWall")
  
	ceiling = atlas.find_region("mod/ceiling")
	ceilingMod1 = atlas.find_region("mod/ceilingMod1")
	ceilingMod2 = atlas.find_region("mod/ceilingMod2")
	ceilingMod3 = atlas.find_region("mod/ceilingMod3")
	ceilingMod4 = atlas.find_region("mod/ceilingMod4")
	ceilingMod5 = atlas.find_region("mod/ceilingMod5")
	ceilingMod6 = atlas.find_region("mod/ceilingMod6")


func _ready() -> void:
	load_scene()
	refresh_scene()
	rooms = [combat_room, event_room, campfire_room]
	# print("rooms:", rooms)
	


func load_scene() -> void:
	super.load_scene()
	set_texture(mg_sprite, mg)
	set_texture(left_wall_sprite, left_wall)
	set_texture(hollow_wall_sprite, hollow_wall)
	set_texture(solid_wall_sprite, solid_wall)
	set_texture(ceiling_sprite, ceiling)
	set_texture(ceilingMod1_sprite, ceilingMod1)
	set_texture(ceilingMod2_sprite, ceilingMod2)
	set_texture(ceilingMod3_sprite, ceilingMod3)
	set_texture(ceilingMod4_sprite, ceilingMod4)
	set_texture(ceilingMod5_sprite, ceilingMod5)
	set_texture(ceilingMod6_sprite, ceilingMod6)
	set_texture(fg_sprite, fg)


func open_combat_room() -> void:
	for room: Control in rooms:
		room.visible = true if room == combat_room else false
	# background
	bg_sprite.visible = true
	mg_sprite.visible = true
	left_wall_sprite.visible = draw_left_wall
	hollow_wall_sprite.visible = draw_hollow_wall
	solid_wall_sprite.visible = draw_solid_wall
	ceiling_sprite.visible = true
	ceilingMod1_sprite.visible = draw_ceilingMod1
	ceilingMod2_sprite.visible = draw_ceilingMod2
	ceilingMod3_sprite.visible = draw_ceilingMod3
	ceilingMod4_sprite.visible = draw_ceilingMod4
	ceilingMod5_sprite.visible = draw_ceilingMod5
	ceilingMod6_sprite.visible = draw_ceilingMod6

	dust_effect.play()
	fog_effect.play()
	for torch in torches:
		torch.play()
	
	# foreground
	fg_sprite.visible = true


func randomize_scene(rng: RandomNumberGenerator) -> void:
	draw_hollow_wall = bool(rng.randi_range(0, 1))
	if draw_hollow_wall:
		draw_solid_wall = bool(rng.randi_range(0, 1))
		if draw_solid_wall:
			draw_left_wall = bool(rng.randi_range(0, 1))
	else:
		draw_solid_wall = true
		draw_left_wall = bool(rng.randi_range(0, 1))
	
	draw_ceilingMod1 = bool(rng.randi_range(0, 1))
	draw_ceilingMod2 = bool(rng.randi_range(0, 1))
	draw_ceilingMod3 = bool(rng.randi_range(0, 1))
	draw_ceilingMod4 = bool(rng.randi_range(0, 1))
	draw_ceilingMod5 = bool(rng.randi_range(0, 1))
	draw_ceilingMod6 = bool(rng.randi_range(0, 1))

	randomize_torch(rng)

func randomize_torch(rng: RandomNumberGenerator) -> void:
	for torch in torches:
		recycle_torch_effect(torch)
	torches.clear()

	if rng.randf() < 0.1:
		add_torch_to(Vector2(1790, 1080 - 850))

	if draw_hollow_wall and not draw_solid_wall:
		var roll = rng.randi_range(0, 2)
		if roll == 0:
			add_torch_to(Vector2(800, 1080 - 768))
			add_torch_to(Vector2(1206, 1080 - 768))
		if roll == 1:
			add_torch_to(Vector2(328, 1080 - 865))
	elif not draw_left_wall and not draw_hollow_wall:
		if rng.randf() < 0.75:
			add_torch_to(Vector2(613, 1080 - 860))
			add_torch_to(Vector2(613, 1080 - 672))

			if rng.randf() < 0.3:
				add_torch_to(Vector2(1482, 1080 - 860))
				add_torch_to(Vector2(1482, 1080 - 672))
	elif draw_solid_wall and draw_hollow_wall:
		if not draw_left_wall:
			var roll = rng.randi_range(0, 3)
			if roll < 1:
				add_torch_to(Vector2(912, 1080 - 790))
				add_torch_to(Vector2(912, 1080 - 526))
				add_torch_to(Vector2(844, 1080 - 658))
				add_torch_to(Vector2(980, 1080 - 658))
			elif roll < 2:
				add_torch_to(Vector2(1828, 1080 - 720))
		elif rng.randf() < 0.75:
			add_torch_to(Vector2(970, 1080 - 874))
	elif draw_left_wall and not draw_hollow_wall:
		if rng.randf() < 0.75:
			add_torch_to(Vector2(970, 1080 - 873))
			add_torch_to(Vector2(616, 1080 - 813))
			add_torch_to(Vector2(1266, 1080 - 708))

func close_effects() -> void:
	for torch in torches:
		torch.stop()

func show_effects() -> void:
	torch_container.visible = true

func hide_effects() -> void:
	torch_container.visible = false
	
func add_torch_to(pos: Vector2) -> InteractableTorchEffect:
	var torch_effect: InteractableTorchEffect = get_idle_torch_effect(torch_effect_prefab)
	torch_container.add_child(torch_effect)
	torch_effect.name = "torch_" + str(torches.size())
	torch_effect.position = pos
	torches.append(torch_effect)
	return torch_effect


static func get_idle_torch_effect(prefab: PackedScene) -> InteractableTorchEffect:
	var effect: InteractableTorchEffect
	if torch_effect_pool.size() > 0:
		effect = torch_effect_pool.pop_front()
		effect.show()
		return effect
	
	effect = prefab.instantiate()
	effect.show()
	return effect

static func recycle_torch_effect(effect: InteractableTorchEffect) -> void:
	effect.stop()
	effect.hide()
	if effect.get_parent() != null:
		effect.get_parent().remove_child(effect)
	torch_effect_pool.append(effect)
