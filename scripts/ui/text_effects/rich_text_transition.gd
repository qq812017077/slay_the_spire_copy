@tool
class_name RichTextTransition
extends RichTextLabel

@export var all_at_once: bool = false
@export_range(0.0, 1.0) var time: float = 0.0
@export var reverse: bool = false
func _enter_tree() -> void:
	pass

func _exit_tree() -> void:
	pass
