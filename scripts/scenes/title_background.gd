class_name TitleBackground
extends Control

const bg_atlas_path: String = "res://arts/slay_the_spire/title/title.atlas"

static var atlas: TextureAtlas = null


@export_range(0.0, 4.0) var timer: float = 1.5
@export_range(0.0, 1.0) var slider: float = 1.0
@export_group("Base")
@export var sky_texture: TextureRect = null
@export var mg3Bot_texture: TextureRect = null
@export var mg3Top_texture: TextureRect = null
@export var topGlow_texture: TextureRect = null
@export var topGlow2_texture: TextureRect = null
@export var botGlow_texture: TextureRect = null
@export var title_logo_texture: TextureRect = null
@export_group("")
@export_group("Dust")
@export var dust_container: Control = null
@export_group("")
@export_group("Clouds")
@export var top_clouds_container: Control = null
@export var mid_clouds_container: Control = null
@export_group("")
var main_menu_screen: MainMenuScreen = null

var sky: AtlasRegion = null
var mg3Bot: AtlasRegion = null
var mg3Top: AtlasRegion = null
var topGlow: AtlasRegion = null
var topGlow2: AtlasRegion = null
var botGlow: AtlasRegion = null

var top_clouds: Array = []
var mid_clouds: Array = []

var starting_timer: float

var activated: bool = false
var finished: bool = false

var logo_alpha: float = 1.0
var title_logo_init_pos: Vector2

# effect
var dusts: Array[GPUParticles2D] = []

func _init() -> void:
	if atlas == null:
		atlas = TextureAtlas.load(bg_atlas_path)
	starting_timer = timer 
	sky = atlas.find_region("jpg/sky");
	mg3Bot = atlas.find_region("mg3Bot");
	mg3Top = atlas.find_region("mg3Top");
	topGlow = atlas.find_region("mg3TopGlow1");
	topGlow2 = atlas.find_region("mg3TopGlow2");
	botGlow = atlas.find_region("mg3BotGlow");

	
func _ready() -> void:
	title_logo_init_pos = title_logo_texture.position

	for child in dust_container.get_children():
		if child is GPUParticles2D:
			dusts.append(child as GPUParticles2D)

	for i in range(1, 7):
		var top_cloud = TitleCloud.new(atlas.find_region("topCloud" + str(i)), TitleCloud.get_postive_speed())
		top_clouds_container.add_child(top_cloud.texture_rect)
		top_clouds.append(top_cloud)
	
	for i in range(1, 13):
		var mid_cloud = TitleCloud.new(atlas.find_region("midCloud" + str(i)), TitleCloud.get_negative_speed())
		mid_clouds_container.add_child(mid_cloud.texture_rect)
		mid_clouds.append(mid_cloud)
	
	for dust in dusts:
		dust.emitting = false

	await get_tree().process_frame
	scale = Vector2(Settings.x_scale, Settings.y_scale)


func _process(delta: float) -> void:

	render()

	if main_menu_screen.is_darken:
		logo_alpha = MathHelper.lerp_snap(logo_alpha, 0.25, delta * 8.0)
	else:
		logo_alpha = MathHelper.lerp_snap(logo_alpha, 1.0, delta * 8.0)

	# if Input.is_action_just_pressed("mouse_left_click") && not activated:
	# 	activate()
	
	if activated and timer != 0.0 and !finished:
		timer -= delta
		if timer < 0.0:
			timer = 0.0
			finished = true
			for dust in dusts:
				dust.emitting = true
		else:
			slider = 1 - MathHelper.pow4_in(0.0, 1.0, timer / starting_timer)

	for cloud in top_clouds:
		cloud.render(delta, slider)

	for cloud in mid_clouds:
		cloud.render(delta, slider)

	# if not CardGame.main_menu_screen.is_fading_out:
	# 	update_flame()
	
func activate() -> void:
	if activated:
		return 
	activated = true
	timer = starting_timer
	finished = false

func slide_down_instantly() -> void:
	activated = true
	timer = 0.0
	slider = 0.0


func render() -> void:
	render_texture(sky_texture, sky, 0.0, -100.0 * slider)
	render_texture(mg3Bot_texture, mg3Bot, 0.0, roundf(-45.0 * slider - mg3Bot.size.y))
	render_texture(mg3Top_texture, mg3Top, 0.0, roundf(-45.0 * slider))
	render_texture(botGlow_texture, botGlow, 0.0, roundf(-45.0 * slider - mg3Bot.size.y))
	render_texture(topGlow_texture, topGlow, 0.0, roundf(-45.0 * slider))
	render_texture(topGlow2_texture, topGlow2, 0.0, roundf(-45.0 * slider))

	var time: int = int(float(Time.get_ticks_msec()) / 16.0) % 360
	var alpha = 0.1 + cos(deg_to_rad(float(time)) + 1.25) / 5.0
	var color: Color = Color(1.0, 0.2, 0.1, alpha)
	botGlow_texture.modulate = color
	topGlow_texture.modulate = color
	topGlow2_texture.modulate = color

	# render dust effect

	title_logo_texture.position = Vector2(
		title_logo_init_pos.x,
		title_logo_init_pos.y - 70.0 * slider + 14.0,
	)
	title_logo_texture.modulate = Color(1.0, 1.0, 1.0, logo_alpha)
	

func render_texture(texture_rect: TextureRect, region: AtlasRegion, x: float, y: float):
	texture_rect.position = Vector2(
			x + region.offset.x,
			y + region.offset.y
		)

func install_textures() -> void:
	install_texture(sky_texture, sky)
	install_texture(mg3Bot_texture, mg3Bot)
	install_texture(mg3Top_texture, mg3Top)
	install_texture(botGlow_texture, botGlow)
	install_texture(topGlow_texture, topGlow)
	install_texture(topGlow2_texture, topGlow2)

func install_texture(texture_rect: TextureRect, region: AtlasRegion):
	texture_rect.texture = TextureHelper.get_cached_texture(region)
	texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	texture_rect.stretch_mode = TextureRect.STRETCH_SCALE
	
	texture_rect.size = Vector2(region.size.x, region.size.y) * Settings.x_scale
