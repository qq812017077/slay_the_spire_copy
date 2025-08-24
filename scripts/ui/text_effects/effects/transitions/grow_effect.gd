@tool
class_name GrowEffect
extends RichTextEffectBase

var bbcode := "growin"

# func bounce(t, wave = 8.0) -> float:
# 	return sin(13.0 * HALFPI * t) * pow(2.0, wave * (t - 1.0))

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var bump_amt:float = char_fx.env.get("amount", 20.0)

	var time: float = get_traisition_label().get_time(char_fx.range.x)

	char_fx.color.a = CardGame.interpolation._apply_powout(0, 1, time, 2)
	var offset_y: float = CardGame.interpolation._apply_powout(bump_amt, 0, time, 2)
	var scale : float= CardGame.interpolation._apply_powout(0, 1, time, 2)
	# char_fx.transform.y = CardGame.interpolation._apply_powout(bump_amt, 0, get_traisition_label().get_time(char_fx.range.x))
	var cs := get_char_size(char_fx) * Vector2(0.5, -0.25)
	char_fx.transform *= Transform2D.IDENTITY.translated(cs)
	char_fx.transform *= Transform2D.IDENTITY.scaled(Vector2.ONE * scale)
	char_fx.transform *= Transform2D.IDENTITY.translated(-cs)
	char_fx.transform *= Transform2D.IDENTITY.translated(Vector2(0, offset_y))
	return true
