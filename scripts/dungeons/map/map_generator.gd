class_name MapGenerator
extends Object


static func generate_dungeon(height: int, width: int, path_density: int, rng: RandomNumberGenerator) -> Array[Array]:
	var nodes: Array[Array] = create_node(height, width)
	var map: Array[Array] = create_paths(nodes, path_density, rng)

	return filter_redundant_edges_from_rows(map)

static func filter_redundant_edges_from_rows(map: Array[Array]) -> Array[Array]:
	var existing_edges: Array[MapEdge] = []
	var delete_list: Array[MapEdge] = []
	for node: MapRoomNode in map[0]:
		if node.has_edges():
			for edge in node.edges:
				for exist_edge in existing_edges:
					if exist_edge.dist == edge.dist:
						delete_list.append(edge)
			
			for del_node in delete_list:
				node.delete_node(del_node)
			delete_list.clear()
	return map

static func create_node(height: int, width: int) -> Array[Array]:
	var nodes: Array[Array] = []
	for y in range(height):
		var row: Array = []
		for x in range(width):
			row.append(MapRoomNode.new(x, y))
		
		nodes.append(row)
	return nodes

static func create_paths(nodes: Array[Array], path_density: int, rng: RandomNumberGenerator) -> Array[Array]:
	var row_size = nodes[0].size() - 1

	var first_starting_node: int = -1
	for i in range(path_density):
		var starting_node: int = rng.randi_range(0, row_size)
		if i == 0:
			first_starting_node = starting_node
		
		# 第二个开始点确保使用一个不同的起始点，即至少两个起点
		while starting_node == first_starting_node and i == 1:
			starting_node = rng.randi_range(0, row_size)

		var src: Vector2i = Vector2i(starting_node, -1)
		var dst: Vector2i = Vector2i(starting_node, 0)
		_create_paths(nodes, MapEdge.new(src, dst), rng)
	return nodes

# The below function 
static func _create_paths(nodes: Array[Array], edge: MapEdge, rng: RandomNumberGenerator) -> Array[Array]:
	var height = nodes.size()

	var cur_pos: Vector2i = edge.dst
	var cur_node: MapRoomNode = get_node_by_pos(nodes, cur_pos)
	
	var row_idx = cur_pos.y
	var col_idx = cur_pos.x
	# is boss node
	if row_idx + 1 >= height:
		cur_node.add_edge(MapEdge.new(cur_pos, Vector2i(3, row_idx + 2)))
		return nodes

	# normal node

	# get next node randomly(-1 0 1)
	var row_width = nodes[row_idx].size()
	var row_end_node = row_width - 1
	var next_offset_x: int = 0
	if col_idx == 0:
		next_offset_x = rng.randi_range(0, 1)
	elif col_idx == row_end_node:
		next_offset_x = rng.randi_range(-1, 0)
	else:
		next_offset_x = rng.randi_range(-1, 1)
	var next_pos = cur_pos + Vector2i(next_offset_x, 1)
	var next_node_candidate: MapRoomNode = get_node_by_pos(nodes, next_pos)

	var new_edge_x = col_idx + next_offset_x
	var new_edge_y = row_idx + 1
	
	if next_node_candidate.has_parents():
		var next_parents: Array[MapRoomNode] = next_node_candidate.get_parents()
		for p_node in next_parents:
			if p_node == cur_node:
				continue
			var ancestor: MapRoomNode = get_common_ancestor(p_node, cur_node, 5)
			if ancestor == null or (next_pos.y - ancestor.y) >= 3:
				continue
			# if not same and have a same ancestor
			if next_pos.x > cur_node.x: # in right forward
				new_edge_x = col_idx + rng.randi_range(-1, 0)
				if new_edge_x < 0:
					new_edge_x = col_idx
			elif next_pos.x == cur_node.x:
				new_edge_x = col_idx + rng.randi_range(-1, 1)
				if new_edge_x < 0:
					new_edge_x = col_idx + 1
				elif new_edge_x > row_end_node:
					new_edge_x = col_idx - 1
			else: # in left backward
				new_edge_x = col_idx + rng.randi_range(0, 1)
				if new_edge_x > row_end_node:
					new_edge_x = col_idx
			next_pos = Vector2i(new_edge_x, new_edge_y)
	
	# avoid cross edge（避免出现交叉）
	if col_idx != 0:
		var left_node: MapRoomNode = nodes[row_idx][col_idx - 1]
		if left_node.has_edges():
			var right_edge_of_left_node = left_node.get_max_edge()
			new_edge_x = max(right_edge_of_left_node.dst.x, new_edge_x)
	
	if col_idx < row_end_node:
		var right_node: MapRoomNode = nodes[row_idx][col_idx + 1]
		if right_node.has_edges():
			var left_edge_of_right_node = right_node.get_min_edge()
			new_edge_x = min(left_edge_of_right_node.dst.x, new_edge_x)
	
	next_pos = Vector2i(new_edge_x, new_edge_y)
	next_node_candidate = get_node_by_pos(nodes, next_pos)
	var new_edge = MapEdge.new(cur_pos, next_pos)
	cur_node.add_edge(new_edge)
	next_node_candidate.add_parent(cur_node)
	return _create_paths(nodes, new_edge, rng)

static func get_common_ancestor(node1: MapRoomNode, node2: MapRoomNode, max_depth: int) -> MapRoomNode:
	if node1.y != node2.y:
		push_error("无法查找不在同一层的节点")
		return null
	if node1 == node2:
		push_error("目标不应为同一个节点")
		return null
	
	var left: MapRoomNode = node1 if node1.x < node2.y else node2
	var right: MapRoomNode = node2 if node1.x < node2.y else node1
	var cur_y: int = node1.y
	var cur_depth: int = 0
	while cur_y >= 0 and cur_depth < max_depth && left.has_parents() && right.has_parents():
		left = get_node_with_max_x(left.parents)
		right = get_node_with_min_x(right.parents)
		if left == right:
			return left
		cur_y -= 1
		cur_depth += 1
	return null

static func get_node_with_max_x(nodes: Array[MapRoomNode]) -> MapRoomNode:
	var max_node: MapRoomNode = nodes[0]
	for node in nodes:
		if node.x > max_node.x:
			max_node = node
	return max_node

static func get_node_with_min_x(nodes: Array[MapRoomNode]) -> MapRoomNode:
	var min_node: MapRoomNode = nodes[0]
	for node in nodes:
		if node.x < min_node.x:
			min_node = node
	return min_node

static func get_node_by_pos(nodes: Array[Array], pos: Vector2i) -> MapRoomNode:
	return nodes[pos.y][pos.x]
