@tool
class_name HealthBar
extends Control
const SHOW_TIME: float = 0.7

const HEALTH_BAR_HEIGHT: float = 20.0
const HEALTH_BG_OFFSET_X: float = 31.0
const HEALTH_BG_OFFSET_Y: float = 0.0

const HEALTH_BAR_OFFSET_Y: float = 0.0
const Y_OFFSET_DIST: float = 12.0

const HEALTH_BAR_PAUSE_DURATION: float = 1.2

static var ui_string: UIString
static var TEXT: Array = []



@export var update: bool = false
@export_range(0.0, 1.0) var alpha: float = 0.0
@export var target_pos: Vector2 = Vector2(0, 0)
@export var health_bar_width: float = 200.0
@export var target_hb_width: float = 0.0


@export_group("BG")
@export var bg_shadow_color: Color = Color(0.0, 0.0, 0.0, 0.0)
@export var left_shadow_bg: TextureRect
@export var body_shadow_bg: TextureRect
@export var right_shadow_bg: TextureRect

@export var bg_color: Color = Color(0.0, 0.0, 0.0, 0.0)
@export var left_bg: TextureRect
@export var body_bg: TextureRect
@export var right_bg: TextureRect
@export_group("")

@export_group("Orange Bar")
@export var orange_bar: Control = null
@export var orange_bar_color: Color = Color(1.0, 0.5, 0.0, 0.0)
@export var orange_left_bar: TextureRect
@export var orange_body_bar: TextureRect
@export var orange_right_bar: TextureRect
@export_group("")
@export var text_color: Color = Color(1.0, 1.0, 1.0, 1.0)


@export_group("Orange Bar")
@export var red_bar: Control = null
@export var red_bar_color: Color = Color(0.8, 0.05, 0.05, 1.0)
@export var red_left_bar: TextureRect
@export var red_body_bar: TextureRect
@export var red_right_bar: TextureRect
@export_group("")

@export_group("Green Bar")
@export var green_bar: Control = null
@export var green_bar_color: Color = Color(120/255.0, 193/255.0, 60/255.0, 1.0)
@export var green_left_bar: TextureRect
@export var green_body_bar: TextureRect
@export var green_right_bar: TextureRect
@export_group("")

@export_group("Blue Bar")
@export var blue_bar: Control = null
@export var blue_bar_color: Color = Color(49/255.0, 86/255.0, 140/255.0, 1.0)
@export_group("")

@export var block_outline_color: Color = Color(1.0, 1.0, 1.0, 1.0)

@export_group("Text")
@export var health_text: Label
@export_group("")
var source: AbstractCreature = null
var hb_anim_timer: float = 0.0
var show_timer: float = 0.0
var y_offset: float = 0.0

var heal_hide_timer: float = 1.0
var button: Button = null

func _ready() -> void:
	ThemeHelper.apply_label_font_style_with_settings(health_text, ThemeHelper.health_info_label_settings, Color.WHITE)

	button = ButtonHelper.create_fit_button(body_shadow_bg, self)
	target_pos = position

	build_bg()
	build_orange_health_bar()
	build_red_health_bar()

	hide_health_bar()


func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		if update:
			build_bg()
			build_orange_health_bar()
			build_red_health_bar()
			update_alpha(delta)
		return
	
	position = target_pos
	update_hover_fade(delta)
	update_health_bar(delta)
	update_health_text()

	update_damage_animation(delta)

func bind_source(src: AbstractCreature, width: float) -> void:
	source = src
	health_bar_width = width

func health_bar_updated_event() -> void:
	hb_anim_timer = HEALTH_BAR_PAUSE_DURATION
	target_hb_width = source.current_health / float(source.max_health)  * button.size.x
	if source.max_health == source.current_health:
		health_bar_width = target_hb_width
	elif source.current_health == 0:
		health_bar_width = 0.0
		target_hb_width = 0.0
	
	if target_hb_width > health_bar_width:
		health_bar_width = target_hb_width


func update_hover_fade(delta: float) -> void:
	if button.is_hovered():
		heal_hide_timer = max(0.2 , heal_hide_timer - delta * 4.0)
	else:
		heal_hide_timer = min(1.0 , heal_hide_timer + delta * 4.0)
	
func update_health_bar(delta: float) -> void:
	if show_timer > 0.0:
		show_timer = max(0.0, show_timer - delta)

		alpha = CardGame.interpolation.apply_fade(0.0, 1.0, 1.0 - show_timer / SHOW_TIME)
		y_offset = CardGame.interpolation._apply_powout(Y_OFFSET_DIST * 5.0, 0.0, 1.0 - show_timer / SHOW_TIME)

	update_alpha(delta)
	if target_hb_width > 0.0:
		orange_bar.visible = true
		red_bar.visible = true
	else:
		orange_bar.visible = false
		red_bar.visible = false
	
	update_orange_health_bar()
	update_red_health_bar()
	# update_green_health_bar()

func update_orange_health_bar() -> void:
	orange_body_bar.size = Vector2(health_bar_width, HEALTH_BAR_HEIGHT)
	orange_right_bar.position = Vector2(health_bar_width, HEALTH_BAR_OFFSET_Y)

func update_green_health_bar() -> void:
	green_left_bar.visible = source.current_health > 0 if source else true
	green_body_bar.size = Vector2(target_hb_width, HEALTH_BAR_HEIGHT)
	green_right_bar.position = Vector2(target_hb_width, HEALTH_BAR_OFFSET_Y)

func update_red_health_bar() -> void:
	var color: Color = blue_bar_color if source and source.cur_block > 0 else red_bar_color
	red_body_bar.modulate = color
	red_left_bar.modulate = color
	red_right_bar.modulate = color

	red_left_bar.visible = source.current_health > 0 if source else true
	red_body_bar.size = Vector2(target_hb_width, HEALTH_BAR_HEIGHT)
	red_right_bar.position = Vector2(target_hb_width, HEALTH_BAR_OFFSET_Y)


func update_alpha(delta: float) -> void:
	if source is AbstractMonster and (source as AbstractMonster).is_escaping:
		alpha = MathHelper.lerp_snap(alpha, 0.0, delta * 12.0)
		target_hb_width = 0.0
		bg_color.a = alpha * 0.75
		bg_shadow_color.a = alpha * 0.5
		text_color.a = alpha
		orange_bar_color.a = alpha
		red_bar_color.a = alpha
		green_bar_color.a = alpha
		blue_bar_color.a = alpha
		block_outline_color.a = alpha
	elif target_hb_width > 0.0 or hb_anim_timer > 0.0:
		bg_color.a = alpha * 0.5
		bg_shadow_color.a = alpha * 0.2
		text_color.a = alpha
		orange_bar_color.a = alpha
		red_bar_color.a = alpha
		green_bar_color.a = alpha
		blue_bar_color.a = alpha
		block_outline_color.a = alpha
	else:
		bg_shadow_color.a = MathHelper.lerp_snap(bg_shadow_color.a, 0.0, delta * 12.0)
		bg_color.a = MathHelper.lerp_snap(bg_color.a, 0.0, delta * 12.0)
		text_color.a = MathHelper.lerp_snap(text_color.a, 0.0, delta * 12.0)
		block_outline_color.a = MathHelper.lerp_snap(block_outline_color.a, 0.0, delta * 12.0)
		

func show_health_bar() -> void:
	show_timer = SHOW_TIME
	alpha = 0.0

func hide_health_bar() -> void:
	alpha = 0.0

func update_health_text() -> void:
	if target_hb_width > 0.0:
		health_text.modulate = text_color
		health_text.modulate.a = text_color.a * heal_hide_timer

		health_text.text = str(source.current_health) + "/" + str(source.max_health) if source else str(int(target_hb_width)) + "/" + str(int(health_bar_width))
	else:
		health_text.text = AbstractCreature.TEXT[0]
	
	health_text.position = Vector2(button.size.x / 2.0 - health_text.size.x / 2.0, -health_text.size.y / 2.0 + HEALTH_BAR_HEIGHT / 2.0)

func update_damage_animation(delta: float) -> void:
	if hb_anim_timer > 0.0:
		hb_anim_timer = max(0.0, hb_anim_timer - delta)
	
	if health_bar_width != target_hb_width and hb_anim_timer <= 0.0 and target_hb_width < health_bar_width:
		health_bar_width = MathHelper.lerp_snap(health_bar_width, target_hb_width, delta * 9.0)



func build_bg() -> void:
	left_shadow_bg.modulate = bg_shadow_color
	body_shadow_bg.modulate = bg_shadow_color
	right_shadow_bg.modulate = bg_shadow_color
	left_shadow_bg.size = Vector2(HEALTH_BAR_HEIGHT, HEALTH_BAR_HEIGHT)
	body_shadow_bg.size = Vector2(health_bar_width, HEALTH_BAR_HEIGHT)
	right_shadow_bg.size = Vector2(HEALTH_BAR_HEIGHT, HEALTH_BAR_HEIGHT)

	left_shadow_bg.position = Vector2(-HEALTH_BAR_HEIGHT, HEALTH_BG_OFFSET_Y)
	body_shadow_bg.position = Vector2(0, HEALTH_BG_OFFSET_Y)
	right_shadow_bg.position = Vector2(health_bar_width, HEALTH_BG_OFFSET_Y)

	left_bg.modulate = bg_color
	body_bg.modulate = bg_color
	right_bg.modulate = bg_color
	left_bg.size = Vector2(HEALTH_BAR_HEIGHT, HEALTH_BAR_HEIGHT)
	body_bg.size = Vector2(health_bar_width, HEALTH_BAR_HEIGHT)
	right_bg.size = Vector2(HEALTH_BAR_HEIGHT, HEALTH_BAR_HEIGHT)

	left_bg.position = Vector2(-HEALTH_BAR_HEIGHT, HEALTH_BAR_OFFSET_Y)
	body_bg.position = Vector2(0, HEALTH_BAR_OFFSET_Y)
	right_bg.position = Vector2(health_bar_width, HEALTH_BAR_OFFSET_Y)


func build_orange_health_bar() -> void:
	orange_left_bar.modulate = orange_bar_color
	orange_body_bar.modulate = orange_bar_color
	orange_right_bar.modulate = orange_bar_color
	orange_left_bar.size = Vector2(HEALTH_BAR_HEIGHT, HEALTH_BAR_HEIGHT)
	orange_body_bar.size = Vector2(health_bar_width, HEALTH_BAR_HEIGHT)
	orange_right_bar.size = Vector2(HEALTH_BAR_HEIGHT, HEALTH_BAR_HEIGHT)

	orange_left_bar.position = Vector2(-HEALTH_BAR_HEIGHT, HEALTH_BAR_OFFSET_Y)
	orange_body_bar.position = Vector2(0, HEALTH_BAR_OFFSET_Y)
	orange_right_bar.position = Vector2(health_bar_width, HEALTH_BAR_OFFSET_Y)


func build_green_health_bar() -> void:
	green_left_bar.modulate = green_bar_color
	green_body_bar.modulate = green_bar_color
	green_right_bar.modulate = green_bar_color
	green_left_bar.size = Vector2(HEALTH_BAR_HEIGHT, HEALTH_BAR_HEIGHT)
	green_body_bar.size = Vector2(target_hb_width, HEALTH_BAR_HEIGHT)
	green_right_bar.size = Vector2(HEALTH_BAR_HEIGHT, HEALTH_BAR_HEIGHT)
	
	green_left_bar.position = Vector2(-HEALTH_BAR_HEIGHT, HEALTH_BAR_OFFSET_Y)
	green_body_bar.position = Vector2(0, HEALTH_BAR_OFFSET_Y)
	green_right_bar.position = Vector2(target_hb_width, HEALTH_BAR_OFFSET_Y)
	


func build_red_health_bar() -> void:
	var color: Color = blue_bar_color if source and source.cur_block > 0 else red_bar_color
	red_body_bar.modulate = color
	red_left_bar.modulate = color
	red_right_bar.modulate = color

	red_left_bar.visible = source.current_health > 0 if source else true
	red_left_bar.size = Vector2(HEALTH_BAR_HEIGHT, HEALTH_BAR_HEIGHT)
	red_body_bar.size = Vector2(target_hb_width, HEALTH_BAR_HEIGHT)
	red_right_bar.size = Vector2(HEALTH_BAR_HEIGHT, HEALTH_BAR_HEIGHT)

	red_left_bar.position = Vector2(-HEALTH_BAR_HEIGHT, HEALTH_BAR_OFFSET_Y)
	red_body_bar.position = Vector2(0, HEALTH_BAR_OFFSET_Y)
	red_right_bar.position = Vector2(target_hb_width, HEALTH_BAR_OFFSET_Y)
	
