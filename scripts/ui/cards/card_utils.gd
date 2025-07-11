class_name CardUtils
extends Object

static func move_object(target: Node, to: Node) -> void:
	if target.get_parent() != null:
		var global_pos = target.global_position
		target.get_parent().remove_child(target)
		to.add_child(target)
		target.global_position = global_pos
	else:
		to.add_child(target)


static func remove_object(target: Node):
	var parent = target.get_parent()
	if parent != null:
		parent.remove_child(target)
	target.queue_free()
	
	
static func shuffle_array(array: Array)  -> void:
	for i in range(array.size() - 1, 0, -1):
		var j = randi() % (i + 1)
		var temp = array[i]
		array[i] = array[j]
		array[j] = temp