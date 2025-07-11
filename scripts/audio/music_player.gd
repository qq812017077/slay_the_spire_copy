class_name MusicPlayer
extends AudioStreamPlayer

const FADE_IN_TIME = 4
const FADE_OUT_TIME = 4
const SILENCE_TIME = 4

var fade_timer: float = 0
var fading_out_start_volume: float
var is_slienced: bool = false
var silence_timer: float = 0
var silence_start_time: float
var silence_start_volume: float
var is_fading_out: bool = false
var is_done: bool = false


func _init(music: AudioStream) -> void:
	music.loop = true
	stream = music
	fade_timer = FADE_IN_TIME



func _process(delta: float) -> void:
	if not is_fading_out:
		update_fading_in(delta)
	else:
		update_fading_out(delta)

func fade_out() -> void:
	is_fading_out = true
	fading_out_start_volume = volume_linear
	fade_timer = FADE_OUT_TIME

func silence() -> void:
	is_slienced = true
	silence_timer = SILENCE_TIME
	silence_start_time = SILENCE_TIME
	silence_start_volume = volume_linear

func silence_instantly() -> void:
	is_slienced = true
	silence_timer = 0.25
	silence_start_time = 0.25
	silence_start_volume = volume_linear

func unsilence() -> void:
	is_slienced = false
	fade_timer = FADE_IN_TIME

func kill() -> void:
	stop()
	is_done = true
	stream = null

func update_fading_in(delta: float) -> void:
	if not is_slienced:
		fade_timer = max(fade_timer - delta, 0)
		if not Settings.is_backgrounded:
			volume_linear = CardGame.interpolation.apply_fade(0, 1, 1 - (fade_timer / FADE_IN_TIME)) * Settings.MUSIC_VOLUME * Settings.MASTER_VOLUME
		else:
			volume_linear = MathHelper.lerp_snap(volume_linear, 0, delta * 3)
	else:
		silence_timer = max(silence_timer - delta, 0)
		if not Settings.is_backgrounded:
			volume_linear = CardGame.interpolation.apply_fade(silence_start_volume, 0, 1 - (silence_timer / silence_start_time))
		else:
			volume_linear = MathHelper.lerp_snap(volume_linear, 0, delta * 3)


func update_fading_out(delta: float) -> void:
	if not is_slienced:
		fade_timer -= delta
		if fade_timer < 0.0:
			fade_timer = 0
			is_done = true
		volume_linear = CardGame.interpolation.apply_fade(fading_out_start_volume, 0, 1 - (fade_timer / FADE_OUT_TIME))
	else:
		silence_timer -= delta
		if silence_timer < 0:
			silence_timer = 0
		volume_linear = CardGame.interpolation.apply_fade(silence_start_volume, 0, 1 - (silence_timer / silence_start_time))