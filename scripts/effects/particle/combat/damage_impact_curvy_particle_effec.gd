class_name DamageImpactCurvyParticleEffect
extends AbstractParticleEffect


@export var normal_particle: GPUParticles2D = null
@export var rarity_particle: GPUParticles2D = null

var rarity_color: Color = Color(1.0, 1.0, 1.0, 1.0)
var normal_color: Color = Color(1.0, 1.0, 1.0, 1.0)

func update_particles_color(ncolor: Color, rcolor: Color) -> void:
	normal_color = ncolor
	rarity_color = rcolor

	var normal_material := normal_particle.process_material as ShaderMaterial
	normal_material.set_shader_parameter("color", normal_color)

	var rarity_material := rarity_particle.process_material as ShaderMaterial
	rarity_material.set_shader_parameter("color", rarity_color)