class_name CardHelper
extends Object


static func get_color(r: int, g: int, b: int) -> Color:
	return Color(r / 255.0, g / 255.0, b / 255.0)


static func set_mouse_filter_recursion(node:Control, mouse_filter: Control.MouseFilter) -> void:
	for child in node.get_children():
		var ctrl : Control = child as Control
		if ctrl == null:
			continue
		ctrl.mouse_filter = mouse_filter
		set_mouse_filter_recursion(child, mouse_filter)