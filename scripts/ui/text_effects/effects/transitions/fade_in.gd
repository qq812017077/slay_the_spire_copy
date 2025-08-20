@tool
class_name FadeIn
extends RichTextEffectBase

var bbcode = "fade_in"

# func bounce(t, wave = 8.0) -> float:
# 	return sin(13.0 * HALFPI * t) * pow(2.0, wave * (t - 1.0))

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	char_fx.color.a = get_traisition_label().get_time(char_fx.range.x)
	return true
