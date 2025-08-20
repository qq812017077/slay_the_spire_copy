@tool
class_name ShakyEffect
extends RichTextEffectBase

var bbcode := "shaky"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var scale: float = char_fx.env.get("scale", 2.0)
	var freq: float = char_fx.env.get("freq", 16.0)
	
	# print("label:", get_traisition_label().name)
	# print("char_fx.relative_index:", char_fx.relative_index, " char_fx.range.x:", char_fx.range.x)
	var t = char_fx.elapsed_time
	var s = fmod((char_fx.relative_index + t) * PI * 1.25, TAU)
	var p = sin(t * freq + char_fx.range.x) * .33
	char_fx.offset.x += sin(s) * p * scale
	char_fx.offset.y += cos(s) * p * scale
	return true