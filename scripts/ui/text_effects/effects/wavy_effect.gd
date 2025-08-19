@tool
class_name WavyEffect
extends RichTextEffect

const WAVY_DIST: float = 3.0

var bbcode := "wavy"
var init_sec_time: float = 0.0

func _init() -> void:
	init_sec_time = Time.get_ticks_msec() / 1000.0

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var speed = char_fx.env.get("freq", 6.0)
	var span = char_fx.env.get("span", 5.0)
	var time = Time.get_ticks_msec() / 1000.0 - init_sec_time
	char_fx.offset.y = cos(time * speed + char_fx.relative_index * span) * WAVY_DIST
	return true