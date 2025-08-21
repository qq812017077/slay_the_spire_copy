@tool
class_name RichTextEffectBase
extends RichTextEffect

const c1 := 1.70158
const c3 := c1 + .5


var label: RichTextLabel
var label2: RichTextTransitionLabel

func get_label() -> RichTextLabel:
	if not label:
		label = instance_from_id(get_meta("rt"))
	return label

func get_traisition_label() -> RichTextTransitionLabel:
	if not label2:
		label2 = instance_from_id(get_meta("rt"))
	return label2

func get_text() -> String:
	return get_label().get_parsed_text()

func get_char(c: CharFXTransform) -> String:
	return get_text()[c.range.x]

func get_char_size(c: CharFXTransform) -> Vector2:
	return get_traisition_label().get_normal_font().get_string_size(get_char(c))