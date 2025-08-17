class_name UpgradeHammerImprintEffect
extends AbstractGameEffect

@export var hammer_img: Sprite2D
@export var hammer_glow_img: Sprite2D

var shine_color: Color = Color(1, 1, 1, 0)
var hammer_glow_scale: float = 1.0
var target_scale: float = 1.0
var target_pos: Vector2 = Vector2.ZERO

func _ready() -> void:
	name = "UpgradeHammerImprintEffect"
	color = Color.WHITE
	color.a = 0.7
	duration = 0.7
	starting_duration = duration
	
	target_scale = 1.0 / randf_range(1.0, 1.5)
	rotation_degrees = randi_range(0, 360)
	hammer_glow_scale = 1.0 - duration
	hammer_glow_scale *= hammer_glow_scale
	
	hammer_glow_img.position = target_pos

func _process(delta: float) -> void:
	duration -= delta
	if duration < 0.0:
		is_done = true
	
	color.a = duration

	hammer_glow_scale = 1.7 - duration
	hammer_glow_scale *= hammer_glow_scale * hammer_glow_scale
	target_scale += delta / 20.0

	hammer_img.self_modulate = color
	hammer_img.position = Vector2(randf_range(-2, 2), randf_range(-2, 2)) + target_pos
	hammer_img.scale = Vector2.ONE * scale


	color.a /= 10.0
	hammer_glow_img.self_modulate = color
	hammer_glow_img.scale = Vector2.ONE * hammer_glow_scale
