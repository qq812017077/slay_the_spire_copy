class_name AbstractParticleEffect
extends Control

var particles: Array[GPUParticles2D] = []
@export var play_on_start: bool = false

var is_playing: bool = false
var is_done: bool = false
var one_shot: bool = false
var finished_count: int = 0
var is_paused: bool = false
func _ready() -> void:
	collect_particles(self)
	
	is_playing = play_on_start
	var all_one_shot = true
	for particle: GPUParticles2D in particles:
		particle.emitting = is_playing
		if all_one_shot and particle.one_shot != true:
			all_one_shot = false
	one_shot = all_one_shot
	if one_shot:
		for particle: GPUParticles2D in particles:
			particle.finished.connect(_on_particle_finished)
func collect_particles(cur: Node) -> void:
	for child in cur.get_children():
		if child is GPUParticles2D:
			particles.append(child)
		collect_particles(child)

func play() -> void:
	is_paused = false
	for particle: GPUParticles2D in particles:
		particle.speed_scale = 1.0
		if particle.one_shot:
			particle.restart()
		else:
			particle.emitting = true
		particle.interp_to_end = 0.0
	is_playing = true
	finished_count = 0

func stop(instant: bool = false, set_done: bool = false) -> void:
	for particle: GPUParticles2D in particles:
		particle.emitting = false
	is_playing = false
	if set_done:
		done()
	if instant:
		for particle: GPUParticles2D in particles:
			particle.interp_to_end = 1.0

func pause() -> void:
	if is_paused:
		return
	for particle: GPUParticles2D in particles:
		particle.speed_scale = 0.0
	is_paused = true

func resume() -> void:
	if not is_paused:
		return
	for particle: GPUParticles2D in particles:
		particle.speed_scale = 1.0
	is_paused = false

func reverse() -> void:
	for particle: GPUParticles2D in particles:
		particle.emitting = not particle.emitting
	is_playing = not is_playing

func _on_particle_finished() -> void:
	finished_count += 1
	print("particle finished:", finished_count, "of", particles.size())
	if finished_count == particles.size():
		is_done = true


func done() -> void:
	is_done = true