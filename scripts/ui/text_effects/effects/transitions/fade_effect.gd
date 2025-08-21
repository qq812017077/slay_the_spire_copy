@tool
class_name FadeEffect
extends RichTextEffectBase

# fade is used already.
var bbcode := "fadein"

# func bounce(t, wave = 8.0) -> float:
# 	return sin(13.0 * HALFPI * t) * pow(2.0, wave * (t - 1.0))

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	char_fx.color.a = CardGame.interpolation._apply_powout(0, 1, get_traisition_label().get_time(char_fx.range.x), 2)
	return true
