@tool
class_name BumpEffect
extends RichTextEffectBase

var bbcode := "bumpin"

# func bounce(t, wave = 8.0) -> float:
# 	return sin(13.0 * HALFPI * t) * pow(2.0, wave * (t - 1.0))

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var bump_amt:float = char_fx.env.get("amount", 20.0)
	var time: float = get_traisition_label().get_time(char_fx.range.x)
	char_fx.color.a = CardGame.interpolation._apply_powout(0, 1, time, 2)
	# char_fx.offset.y = CardGame.interpolation._apply_powout(bump_amt, 0, time, 4)
	var offset: Vector2 = Vector2(0, CardGame.interpolation._apply_powout(bump_amt, 0, time, 4))
	char_fx.transform *= Transform2D.IDENTITY.translated(offset)
	return true
