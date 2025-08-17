@tool
class_name CardContainer
extends Container

@export_group("Separation")
@export_range(0, 1000) var h_separation: int = 0:
	set(value):
		h_separation = value
		queue_sort()
@export_range(0, 1000) var v_separation: int = 0:
	set(value):
		v_separation = value
		queue_sort()
@export_group("")

@export_group("Grid")
@export var columns: int = 1:
	set(value):
		columns = value
		queue_sort()
		update_minimum_size()
@export_group("")

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_ACCESSIBILITY_UPDATE:
			pass
		NOTIFICATION_TRANSLATION_CHANGED:
			queue_sort()
		NOTIFICATION_SORT_CHILDREN:
			reposition_children()
			# reupdate_minimum_size()
		NOTIFICATION_LAYOUT_DIRECTION_CHANGED:
			queue_sort()
		NOTIFICATION_THEME_CHANGED:
			update_minimum_size()


func reposition_children() -> void:
	var col_minw: Dictionary = {} # max of min_width of all controls in each col (indexed by col index)
	var row_minh: Dictionary = {} # max of min_height of all controls in each row (indexed by row index)

	var valid_controls_index: int = 0
	for i in range(get_child_count()):
		var child: Control = get_child(i)
		if not child or not child.is_visible():
			continue
		var row: int = valid_controls_index / columns
		var col: int = valid_controls_index % columns
		valid_controls_index += 1
		var minsize = child.get_combined_minimum_size()
		if col_minw.has(col):
			col_minw[col] = max(col_minw[col], minsize.x)
		else:
			col_minw[col] = minsize.x
		
		if row_minh.has(row):
			row_minh[row] = max(row_minh[row], minsize.y)
		else:
			row_minh[row] = minsize.y

	
	var max_col: int = min(valid_controls_index, columns)
	var max_row: int = ceil(float(valid_controls_index) / float(columns))
	
	var remaining_space: Vector2 = get_size()
	for key in col_minw.keys():
		remaining_space.x -= col_minw[key]
	
	for key in row_minh.keys():
		remaining_space.y -= row_minh[key]
	
	remaining_space.y -= max(max_row - 1, 0) * v_separation
	remaining_space.x -= max(max_col - 1, 0) * h_separation

	# fit nodes
	var col_offset: int = 0
	var row_offset: int = 0

	valid_controls_index = 0
	for i in range(get_child_count()):
		var child: Control = get_child(i)
		if not child or not child.is_visible():
			continue
		var row: int = int(float(valid_controls_index) / columns)
		var col: int = valid_controls_index % columns
		valid_controls_index += 1
		if col == 0:
			col_offset = 0
			if row > 0:
				row_offset += row_minh[row - 1] + v_separation
		var c_size: Vector2 = Vector2(col_minw[col], row_minh[row])
		var c_pos: Vector2 = Vector2(col_offset, row_offset)
		fit_child_in_rect(child, Rect2(c_pos, c_size))
		col_offset += int(c_size.x + h_separation)

func custom_fit_child_in_rect(child: Control, rect: Rect2, instant: bool = true) -> void:
	var minsize = child.get_combined_minimum_size()
	
	if child.size_flags_horizontal & SIZE_FILL:
		rect.size.x = minsize.x
		if child.size_flags_vertical & SIZE_SHRINK_END:
			rect.position.x += rect.size.x - minsize.x
		elif child.size_flags_vertical & SIZE_SHRINK_CENTER:
			rect.position.x += floor(rect.size.x - minsize.x) / 2.0
	
	if child.size_flags_vertical & SIZE_FILL:
		rect.size.y = minsize.y
		if child.size_flags_horizontal & SIZE_SHRINK_END:
			rect.position.y += rect.size.y - minsize.y
		elif child.size_flags_horizontal & SIZE_SHRINK_CENTER:
			rect.position.y += floor(rect.size.y - minsize.y) / 2.0
	
	if instant:
		child.set_position(rect.position)
		child.set_size(rect.size)

# func update_minimum_size() -> void:
	
func _get_minimum_size() -> Vector2:
	var col_minw: Dictionary = {} # max of min_width of all controls in each col (indexed by col index)
	var row_minh: Dictionary = {} # max of min_height of all controls in each row (indexed by row index)

	var valid_controls_index: int = 0
	var max_col: int = 0
	var max_row: int = 0
	for i in range(get_child_count()):
		var child: Control = get_child(i)
		if not child or not child.is_visible():
			continue
		var row: int = valid_controls_index / columns
		var col: int = valid_controls_index % columns
		valid_controls_index += 1
		var minsize = child.get_combined_minimum_size()
		if col_minw.has(col):
			col_minw[col] = max(col_minw[col], minsize.x)
		else:
			col_minw[col] = minsize.x
		
		if row_minh.has(row):
			row_minh[row] = max(row_minh[row], minsize.y)
		else:
			row_minh[row] = minsize.y

		max_col = max(max_col, col)
		max_row = max(max_row, row)

	var ms: Vector2 = Vector2(0, 0)
	for key in col_minw.keys():
		ms.x += col_minw[key]
	for key in row_minh.keys():
		ms.y += row_minh[key]
		
	ms.x += max_col * v_separation
	ms.y += max_row * h_separation
	return ms

