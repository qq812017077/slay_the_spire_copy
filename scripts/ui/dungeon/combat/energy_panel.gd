class_name EnergyPanel
extends Control

const ENERGY_VFX_TIME: float = 2.0

@export var energy_orb: EnergyOrbWidget
@export var gain_energy_sprite: Sprite2D
@export var energe_num_label: Label
@export var total_count: int
var energy_vfx_timer: float = 0.0
var font_scale: float = 1.0
var is_loaded: bool =false

var energy_vfx_alpha: float = 1.0
var energy_vfx_angle: float = 0.0
var energy_vfx_scale: float = 1.0

var gain_energy_sprite_2: Sprite2D


func _ready() -> void:
	gain_energy_sprite.material = MaterialLibrary.add_material

	load_player(IronClad.new())
func _process(delta: float) -> void:
	if not is_loaded:
		return


	energy_orb.update(delta)
	update_vfx(delta)

	if Settings.is_debug:
		if Input.is_key_pressed(KEY_DOWN):
			add_energy(1)
		elif Input.is_key_pressed(KEY_UP):
			use_energy(1)

func update_vfx(delta: float) -> void:
	if energy_vfx_timer >= 0.0:
		energy_vfx_timer = max(energy_vfx_timer - delta, 0.0)
		energy_vfx_alpha = CardGame.interpolation.apply_exp10(0.5, 0.0, 1.0 - energy_vfx_timer / ENERGY_VFX_TIME)
		energy_vfx_angle += delta * -30.0
		energy_vfx_scale = CardGame.interpolation.apply_exp10(1.0, 0.1, 1.0 - energy_vfx_timer / ENERGY_VFX_TIME)

	gain_energy_sprite.modulate.a = energy_vfx_alpha
	gain_energy_sprite.rotation_degrees = -energy_vfx_angle + 50.0
	gain_energy_sprite.scale = Vector2.ONE * energy_vfx_scale

	gain_energy_sprite_2.modulate.a = energy_vfx_alpha
	gain_energy_sprite_2.rotation_degrees = energy_vfx_angle
	gain_energy_sprite_2.scale = Vector2.ONE * energy_vfx_scale

func load_player(_player: AbstractPlayer) -> void:
	_player.setup_orb(energy_orb)
	energy_orb.enable()
	gain_energy_sprite.texture = _player.get_energy_image()
	gain_energy_sprite_2 = gain_energy_sprite.duplicate()
	gain_energy_sprite.get_parent().add_child(gain_energy_sprite_2)
	move_child(gain_energy_sprite_2, gain_energy_sprite.get_index()+1)

	ThemeHelper.apply_label_font_style_with_settings(energe_num_label, _player.get_energy_num_label_settings(), Color(1.0,1.0,0.86,1.0))

	is_loaded = true


func set_energy(energy: int) -> void:
	total_count = energy

	energy_vfx_timer = ENERGY_VFX_TIME
	font_scale = 2.0

	# refresh energy effect

func add_energy(energy: int) -> void:
	total_count += energy

	total_count = min(total_count, 999)

	energy_vfx_timer = ENERGY_VFX_TIME
	font_scale = 2.0
	# refresh energy effect

func use_energy(energy: int) -> void:
	total_count -= energy

	total_count = max(total_count, 0)

	if energy != 0:
		font_scale = 2.0
