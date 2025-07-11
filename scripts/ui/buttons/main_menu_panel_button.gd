class_name MainMenuPanelButton
extends Control

const HOVER_SIZE = Vector2(1.02,1.02)
const NORMAL_SIZE = Vector2.ONE

const Y_OFFSET = 100

@export var swing_in_curve: Curve
@export var panel_type : MenuPanelScreen.PanelType
@export var button: Button = null
@export var panel_img: Sprite2D = null
@export var portrait_img: Sprite2D = null
@export var header: Label = null
@export var description: Label = null

var starting_anim_timer: float = 0
var anim_timer: float = 0
var y_offset: float = 0

var starting_pos: Vector2 
var finish = true
func _ready() -> void:
	ThemeHelper.clean_button_style(button)
	button.text = ""
	ThemeHelper.apply_damage_number_font_style(header)
	ThemeHelper.apply_character_desc_font_style(description)
	
	# await get_tree().process_frame
	starting_pos = position
	
func refresh() -> void:
	starting_anim_timer = randf_range(0.2, 0.35)
	anim_timer = starting_anim_timer
	finish = false

func _process(delta: float) -> void:
	if button.is_hovered():
		panel_img.scale = MathHelper.vec2_lerp_snap(panel_img.scale, HOVER_SIZE, delta * 8)
		panel_img.self_modulate = Color.WHITE * 1.5
	else:
		panel_img.scale = MathHelper.vec2_lerp_snap(panel_img.scale, NORMAL_SIZE, delta * 8)
		panel_img.self_modulate = Color.WHITE

	updating_panel_in(delta)

func updating_panel_in(delta: float) -> void:
	if finish:
		return
	anim_timer -= delta
	if anim_timer < 0:
		anim_timer = 0
		finish = true
	y_offset = Y_OFFSET * swing_in_curve.sample(anim_timer / starting_anim_timer)
	var alpha = 1 - anim_timer / starting_anim_timer
	modulate.a = alpha
	position = starting_pos + Vector2(0, y_offset)