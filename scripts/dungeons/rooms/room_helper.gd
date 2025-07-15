class_name RoomHelper
extends Object


static var elite_room_rule = EliteRoomRule.new()
static var rest_room_rule = RestRoomRule.new()
static var parent_room_rule = ParentRoomRule.new()
static var sibling_room_rule = SiblingRoomRule.new()

static func get_connected_non_assigned_nodes_count(map: Array[Array]) -> int:
	var count: int = 0
	for row in map:
		for node in row:
			if node.has_edges() and node.room == null:
				count += 1
	return count

static func get_sibling_nodes(map: Array[Array], node: MapRoomNode) -> Array[MapRoomNode]:
	var siblings: Array[MapRoomNode] = []
	var parents = node.get_parents()
	for parent in parents:
		for edge: MapEdge in parent.edges:
			var sibling_node: MapRoomNode = map[edge.dst.y][edge.dst.x]
			if sibling_node != node:
				siblings.append(sibling_node)
	return siblings


static func get_applicable_room_according_to_rule(map: Array[Array], node: MapRoomNode, room_list: Array[AbstractRoom]) -> AbstractRoom:
	var parents = node.get_parents()
	var siblings = get_sibling_nodes(map, node)

	for room: AbstractRoom in room_list:
		if not elite_room_rule.satisify(node, room) or not rest_room_rule.satisify(node, room):
			continue
		if parent_room_rule.is_all_satisify(parents, room) and sibling_room_rule.is_all_satisify(siblings, room):
			return room
		if node.y == 0:
			push_error("node.y is zero but it is impossible!")
	return null

static func distribute_rooms_across_map(map: Array[Array], room_list: Array[AbstractRoom], _rng: RandomNumberGenerator) -> void:
	var empty_nodes_count = get_connected_non_assigned_nodes_count(map)
	
	if room_list.size() > empty_nodes_count:
		push_error(("Not enough empty nodes to distribute all rooms."))

	while room_list.size() < empty_nodes_count:
		room_list.append(MonsterRoom.new())
	
	# shuffle room list based on rng
	# room_list.shuffle()
	Global.array_shuffle(_rng, room_list)

	# assign rooms to map
	for row in map:
		for node: MapRoomNode in row:
			if node.y == 0 or not node.has_edges() or node.room != null:
				continue
			var applicable_room = get_applicable_room_according_to_rule(map, node, room_list)
			if applicable_room != null:
				node.room = applicable_room
				room_list.erase(applicable_room)

	final_check(map, null)

static func final_check(map: Array[Array], _n: MapRoomNode = null) -> void:
	for row in map:
		for node: MapRoomNode in row:
			if node != null and node.has_edges() and not node.has_room():
				push_error("Node[{0}, {1}] has no room assigned.".format([node.x, node.y]))
				# push_error(("Node " + node.to_string() + " has no room assigned."))
				node.set_room_by_type(AbstractRoom.RoomType.MONSTER)
