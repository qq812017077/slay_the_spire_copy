@tool
class_name WavyEffect
extends RichTextEffect

const WAVY_DIST: float = 3.0

var bbcode := "wavy"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var speed = char_fx.env.get("freq", 6.0)
	var span = char_fx.env.get("span", 5.0)
	var slow: bool = char_fx.env.get("slow", false)
	
	var scale: float = 0.5 if slow else 1.0
	var t: float = char_fx.elapsed_time
	char_fx.offset.y = cos(t * speed * scale + char_fx.relative_index * span) * WAVY_DIST * scale
	return true