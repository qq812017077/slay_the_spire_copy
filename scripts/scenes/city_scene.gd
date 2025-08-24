class_name CityScene
extends AbstractScene

enum PillarConfig {OPEN, SIDES_ONLY, FULL, LEFT_1, LEFT_2}

const ATLAS_PATH = "res://arts/slay_the_spire/scenes/cityScene/scene.atlas"

@export_group("Combat/Background")
@export var bgGlow_sprite: Sprite2D = null
@export var bgGlow2_sprite: Sprite2D = null
@export var bg2_sprite: Sprite2D = null
@export var bg2Glow_sprite: Sprite2D = null
@export var floor_sprite: Sprite2D = null
@export var ceiling_sprite: Sprite2D = null
@export var wall_sprite: Sprite2D = null
@export var chains_sprite: Sprite2D = null
@export var chainsGlow_sprite: Sprite2D = null
@export var pillar1_sprite: Sprite2D = null
@export var pillar2_sprite: Sprite2D = null
@export var pillar3_sprite: Sprite2D = null
@export var pillar4_sprite: Sprite2D = null
@export var pillar5_sprite: Sprite2D = null
@export var throne_sprite: Sprite2D = null
@export var throneGlow_sprite: Sprite2D = null
@export var mg_sprite: Sprite2D = null
@export var mgGlow_sprite: Sprite2D = null
@export var mg2_sprite: Sprite2D = null
@export_group("")

@export_group("Combat/Effects")
@export_group("")


@export_group("Combat/Foreground")
@export var fg_sprite: Sprite2D = null
@export var fgGlow_sprite: Sprite2D = null
@export var fg2_sprite: Sprite2D = null
@export_group("")

@export_group("Combat/Config")
@export var overlay_color: Color = Color(1, 1, 1, 1)
@export var dark_day: bool = false
@export var has_flies: bool = false
@export var blue_flies: bool = false
@export var draw_alt_bg: bool = false
@export var draw_mg: bool = false
@export var draw_mg_alt: bool = false
@export var draw_mg_glow: bool = false
@export var draw_wall: bool = false
@export var draw_chains: bool = false
@export var draw_fg2: bool = false
@export var pillar_config: PillarConfig
@export var draw_throne: bool = false
@export_group("")

var bgGlow: AtlasRegion = null
var bgGlow2: AtlasRegion = null
var bg2: AtlasRegion = null
var bg2Glow: AtlasRegion = null
var floor: AtlasRegion = null
var ceiling: AtlasRegion = null
var wall: AtlasRegion = null
var chains: AtlasRegion = null
var chainsGlow: AtlasRegion = null
var pillar1: AtlasRegion = null
var pillar2: AtlasRegion = null
var pillar3: AtlasRegion = null
var pillar4: AtlasRegion = null
var pillar5: AtlasRegion = null
var throne: AtlasRegion = null
var throneGlow: AtlasRegion = null
var mg: AtlasRegion = null
var mgGlow: AtlasRegion = null
var mg2: AtlasRegion = null
var fg: AtlasRegion = null
var fgGlow: AtlasRegion = null
var fg2: AtlasRegion = null

var glow_time: float = 0.0
var all_sprites: Array[Sprite2D]
func _init() -> void:
	super (ATLAS_PATH)

	ambiance_name = "AMBIANCE_CITY"
	bg = atlas.find_region("mod/bg1")
	bgGlow = atlas.find_region("mod/bgGlowv2")
	bgGlow2 = atlas.find_region("mod/bgGlowBlur")
	bg2 = atlas.find_region("mod/bg2")
	bg2Glow = atlas.find_region("mod/bg2Glow")
	floor = atlas.find_region("mod/floor")
	ceiling = atlas.find_region("mod/ceiling")
	wall = atlas.find_region("mod/wall")
	chains = atlas.find_region("mod/chains")
	chainsGlow = atlas.find_region("mod/chainsGlow")
	pillar1 = atlas.find_region("mod/p1")
	pillar2 = atlas.find_region("mod/p2")
	pillar3 = atlas.find_region("mod/p3")
	pillar4 = atlas.find_region("mod/p4")
	pillar5 = atlas.find_region("mod/p5")
	throne = atlas.find_region("mod/throne")
	throneGlow = atlas.find_region("mod/throneGlow")
	mg = atlas.find_region("mod/mg1")
	mgGlow = atlas.find_region("mod/mg1Glow")
	mg2 = atlas.find_region("mod/mg2")
	fg = atlas.find_region("mod/fg")
	fgGlow = atlas.find_region("mod/fgGlow")
	fg2 = atlas.find_region("mod/fgHideWindow")


func _ready() -> void:
	load_scene()
	# refresh_scene()
	rooms = [combat_room, event_room, campfire_room]
	open_combat_room()

func _process(delta: float) -> void:
	super._process(delta)
	glow_time += delta
	if combat_room.visible:
		if draw_chains:
			chainsGlow_sprite.modulate.a = cos(fmod(glow_time, 360.0)) / 10.0 + 0.9
		if draw_mg_glow:
			mgGlow_sprite.modulate.a = cos(fmod(glow_time, 360.0)) / 2.0 + 0.5
		

func load_scene() -> void:
	super.load_scene()
	
	set_texture(bgGlow_sprite, bgGlow)
	set_texture(bgGlow2_sprite, bgGlow2)
	set_texture(bg2_sprite, bg2)
	set_texture(bg2Glow_sprite, bg2Glow)
	set_texture(floor_sprite, floor)
	set_texture(ceiling_sprite, ceiling)
	set_texture(wall_sprite, wall)
	set_texture(chains_sprite, chains)
	set_texture(chainsGlow_sprite, chainsGlow)
	set_texture(pillar1_sprite, pillar1)
	set_texture(pillar2_sprite, pillar2)
	set_texture(pillar3_sprite, pillar3)
	set_texture(pillar4_sprite, pillar4)
	set_texture(pillar5_sprite, pillar5)
	set_texture(throne_sprite, throne)
	set_texture(throneGlow_sprite, throneGlow)
	set_texture(mg_sprite, mg)
	set_texture(mgGlow_sprite, mgGlow)
	set_texture(mg2_sprite, mg2)
	set_texture(fg_sprite, fg)
	set_texture(fgGlow_sprite, fgGlow)
	set_texture(fg2_sprite, fg2)

	
	all_sprites = [bgGlow_sprite, bgGlow2_sprite, bg2_sprite, bg2Glow_sprite, floor_sprite, ceiling_sprite, wall_sprite, chains_sprite
	, chainsGlow_sprite, pillar1_sprite, pillar2_sprite, pillar3_sprite, pillar4_sprite, pillar5_sprite, throne_sprite, throneGlow_sprite
	, mg_sprite, mgGlow_sprite, mg2_sprite, fg_sprite, fgGlow_sprite, fg2_sprite]
	bgGlow_sprite.material = MaterialLibrary.add_material
	bgGlow2_sprite.material = MaterialLibrary.add_material
	mgGlow_sprite.material = MaterialLibrary.add_material
	bg2Glow_sprite.material = MaterialLibrary.add_material
	chainsGlow_sprite.material = MaterialLibrary.add_material
	fgGlow_sprite.material = MaterialLibrary.add_material

func randomize_scene(rng: RandomNumberGenerator) -> void:
	overlay_color = Color(rng.randf_range(0.8, 0.9), rng.randf_range(0.8, 0.9), rng.randf_range(0.95, 1.0), 1)
	has_flies = rng.randi_range(0, 1) == 0
	blue_flies = rng.randi_range(0, 1) == 0
	
	dark_day = rng.randf() < 0.33
	if dark_day:
		overlay_color = Color(0.6, rng.randf_range(0.7, 0.8), rng.randf_range(0.8, 0.95), 1)
	
	draw_alt_bg = rng.randi_range(0, 1) == 0
	draw_mg = rng.randi_range(0, 1) == 0
	if draw_mg:
		draw_mg_alt = rng.randi_range(0, 1) == 0
		if not draw_mg_alt:
			draw_mg_glow = rng.randi_range(0, 1) == 0
	
	if CardGame.dungeon_main_screen and CardGame.dungeon_main_screen.dungeon.cur_room_node.room is BossRoom:
		draw_wall = false
	else:
		draw_wall = rng.randi_range(0, 4) == 4
	
	if draw_wall:
		draw_chains = rng.randi_range(0, 1) == 0
		var roll: int = rng.randi_range(0, 2)
		if roll == 0:
			pillar_config = PillarConfig.OPEN
		elif roll == 1:
			pillar_config = PillarConfig.LEFT_1
		else:
			pillar_config = PillarConfig.LEFT_2
	else:
		draw_chains = false
		var roll: int = rng.randi_range(0, 2)
		if roll == 0:
			pillar_config = PillarConfig.OPEN
		elif roll == 1:
			pillar_config = PillarConfig.SIDES_ONLY
		else:
			pillar_config = PillarConfig.FULL
	
	draw_fg2 = rng.randi_range(0, 1) == 0
	
	draw_throne = rng.randi_range(0, 1) == 0

func open_combat_room() -> void:
	for room: Control in rooms:
		room.visible = true if room == combat_room else false
	
	for sprite in all_sprites:
		sprite.visible = false

	bg_sprite.modulate = overlay_color
	bg_sprite.visible = true
	bgGlow_sprite.visible = true
	
	if dark_day:
		bgGlow2_sprite.visible = true
	
	bg2_sprite.modulate = Color.WHITE if dark_day else overlay_color
	bg2_sprite.visible = draw_alt_bg
	bg2Glow_sprite.modulate = Color.WHITE if dark_day else overlay_color
	bg2Glow_sprite.visible = draw_alt_bg

	floor_sprite.modulate = overlay_color
	floor_sprite.visible = true
	ceiling_sprite.modulate = overlay_color
	ceiling_sprite.visible = true

	wall_sprite.modulate = overlay_color
	wall_sprite.visible = draw_wall
	
	chains_sprite.modulate = overlay_color
	chains_sprite.visible = draw_chains

	chainsGlow_sprite.visible = draw_chains

	mg_sprite.modulate = overlay_color
	mg2_sprite.modulate = overlay_color
	mgGlow_sprite.modulate = overlay_color
	mg_sprite.visible = draw_mg
	mg2_sprite.visible = draw_mg_alt
	mgGlow_sprite.visible = draw_mg_glow

	match pillar_config:
		PillarConfig.OPEN:
			pass
		PillarConfig.SIDES_ONLY:
			pillar1_sprite.visible = true
			pillar5_sprite.visible = true
		PillarConfig.FULL:
			pillar1_sprite.visible = true
			pillar2_sprite.visible = true
			pillar3_sprite.visible = true
			pillar4_sprite.visible = true
			pillar5_sprite.visible = true
		PillarConfig.LEFT_1:
			pillar1_sprite.visible = true
		PillarConfig.LEFT_2:
			pillar1_sprite.visible = true
			pillar2_sprite.visible = true
	
	throne_sprite.modulate = overlay_color
	throneGlow_sprite.modulate = overlay_color
	throne_sprite.visible = draw_throne
	throneGlow_sprite.visible = draw_throne

	fg_sprite.visible = true
	
	fgGlow_sprite.visible = true
	fg2_sprite.visible = draw_fg2
