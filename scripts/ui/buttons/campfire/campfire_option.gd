class_name CampfireOption
extends Control

enum Type {REST, SMITH, TOKE, TRAIN, DIG, RECALL}

const UNUSABLE_COLOR = Color.LIGHT_GRAY
const NORM_SCALE = Vector2(0.9, 0.9)
const HOVER_SCALE = Vector2(1.0, 1.0)

const OUTLINE_COLOR = Color(1, 0.93, 0.45, 1)
@export var type: Type = Type.REST
@export var option_name: Label = null
@export var desc: String = ""
@export var img: Sprite2D = null
@export var img_outline: Sprite2D = null

var shadow_img: Sprite2D = null
@onready var btn: Button = $Button
@onready var icon_container: Control = $IconContainer
@onready var shadow_container: Control = $IconContainer/Shadow
var label_offset_y: float = 0
var alpha: float = 1.0

var is_hovered: bool = false
func _ready() -> void:
	shadow_img = img.duplicate()
	shadow_img.name = "ShadowImg"
	shadow_container.add_child(shadow_img)
	
	ThemeHelper.clean_button_style(btn)
	
	shadow_img.offset = Vector2(10, 10)
	shadow_img.material = MaterialLibrary.shadow_material

	ThemeHelper.apply_label_font_style_with_settings(option_name, ThemeHelper.top_panel_info_label_settings, Color.WHITE)
	img_outline.self_modulate = OUTLINE_COLOR
	img_outline.self_modulate.a = 0.0
	option_name.self_modulate = ThemeHelper.GOLD_COLOR
	var icon_rect = icon_container.get_rect()
	label_offset_y = option_name.position.y - icon_rect.position.y - icon_rect.size.y
	icon_container.scale = NORM_SCALE

func initialize(_img: Texture2D) -> void:
	img.texture = _img
	shadow_img.texture = _img


func _process(delta: float) -> void:
	is_hovered = btn.is_hovered()
	var target_scale = HOVER_SCALE if is_hovered else NORM_SCALE
	icon_container.scale = MathHelper.vec2_lerp_snap(icon_container.scale, target_scale, delta * 8)
	
	var icon_rect = icon_container.get_rect()
	option_name.position.y = icon_rect.position.y + icon_rect.size.y + label_offset_y

	img_outline.self_modulate.a = MathHelper.lerp_snap(img_outline.self_modulate.a, 1.0 if is_hovered else 0.0, delta * 8)
	# shadow_img.scale = MathHelper.vec2_lerp_snap(shadow_img.scale, (Vector2.ONE * 0.9) if is_hovered else Vector2.ONE, delta * 8)
	alpha = MathHelper.lerp_snap(alpha, 0 if is_hovered else 1, delta * 4)
	shadow_img.set_instance_shader_parameter("alpha", alpha)


# func on_gui_input(event: InputEvent) -> void:
# 	if event is InputEventMouseButton:
# 		var mouse_event = event as InputEventMouseButton
# 		# if mouse_event.button_index == MOUSE_BUTTON_LEFT and mous

# func on_mouse_entered() -> void:
# 	is_hovered = true

# func on_mouse_exited() -> void:
# 	is_hovered = false
