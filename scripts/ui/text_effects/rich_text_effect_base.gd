@tool
extends RichTextEffect
class_name RichTextEffectBase

const c1 := 1.70158
const c3 := c1 + .5


var label_richtext: RichTextLabel:
	get:
		if not label_richtext:
			var rtid: int = get_meta(&"rt")
			if rtid:
				label_richtext = instance_from_id(rtid)
		return label_richtext
