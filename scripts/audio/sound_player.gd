class_name SoundPlayer
extends AudioStreamPlayer

const FADE_OUT_DURATION : float = 5.0

@export var is_loop: bool = false
@export var is_done: bool = false
var fade_duration: float = 5

var is_fading_out: bool = false

func _init() -> void:
	reset()

func reset() -> void:
	is_done = false
	is_fading_out = false

func kill() -> void:
	stop()
	stream = null
	is_done = true

func _process(delta: float) -> void:
	if is_fading_out:
		update_fading_out(delta)
	else:
		if not is_loop:
			is_done = not playing

func fade_out() -> void:
	is_fading_out = true
	fade_duration = FADE_OUT_DURATION

func update_fading_out(delta: float) -> void:
	if fade_duration > 0.0:
		fade_duration -= delta
		volume_linear = Settings.SOUND_VOLUME * Settings.MASTER_VOLUME * CardGame.interpolation.apply_fade(1, 0, 1 - fade_duration / FADE_OUT_DURATION)
	else:
		is_done = true
		fade_duration = 0

func modify_volume(volume_modifier: float = 0) -> void:
	volume_modifier = clamp(volume_modifier, 0 , 1)
	volume_linear = Settings.SOUND_VOLUME * Settings.MASTER_VOLUME * volume_modifier

func adjust_volume(volume_adjust: float = 0) -> void:
	volume_linear = clamp(volume_linear + volume_adjust, 0, 1)