class_name CampfireBubbleEffect
extends AbstractParticleEffect

@export var particle_process_material: ParticleProcessMaterial = null

func set_particle_position(_position: Vector2, _size: Vector2, _amount: int = 5):
	position = _position
	particle_process_material.emission_shape_offset.x = 0
	particle_process_material.emission_shape_offset.y = 0
	particle_process_material.emission_box_extents.x = _size.x * 0.5
	particle_process_material.emission_box_extents.y = _size.y * 0.5

	for particle in particles:
		if particle.one_shot:
			continue
		particle.amount = _amount