class_name TransitionEffectBase
extends RichTextEffect

const HALFPI = PI / 2.0
const SPACE = " "

func get_tween_data(char_fx: CharFXTransform) -> RichTextLabel:
	var id = char_fx.env.get("id", "main")
	if not id in TextTransitionSettings.transitions:
		push_error("(TransitionBase) No RichTextTransition with id", id, "is registered.")
		return null
	else:
		return TextTransitionSettings.transitions[id]


func get_t(char_fx: CharFXTransform):
	return get_tween_data(char_fx).get_t(char_fx.relative_index)

func get_t_from_rich_text(rt: RichTextLabel, index: int) -> float:
	return 0.0