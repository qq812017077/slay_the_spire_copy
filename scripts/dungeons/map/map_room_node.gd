class_name MapRoomNode
extends Object


var x: int
var y: int
var room: AbstractRoom = null
var parents: Array[MapRoomNode] = []
var edges: Array[MapEdge] = []
func _init(_x, _y) -> void:
	x = _x
	y = _y

func has_room() -> bool:
	return room != null

func set_room(r: AbstractRoom) -> void:
	room = r

func set_room_by_type(_type: AbstractRoom.RoomType) -> void:
	var _room: AbstractRoom
	if _type == AbstractRoom.RoomType.REST:
		_room = RestRoom.new()
	elif _type == AbstractRoom.RoomType.SHOP:
		_room = ShopRoom.new()
	elif _type == AbstractRoom.RoomType.MONSTER:
		_room = MonsterRoom.new()
	elif _type == AbstractRoom.RoomType.SHRINE:
		# room = ShrineRoom.new()
		push_error(("Shrine rooms are not yet implemented."))
	elif _type == AbstractRoom.RoomType.TREASURE:
		_room = TreasureRoom.new()
	elif _type == AbstractRoom.RoomType.EVENT:
		_room = EventRoom.new()
	elif _type == AbstractRoom.RoomType.BOSS:
		_room = BossRoom.new()
	
	room = _room
	
func add_parent(parent: MapRoomNode) -> void:
	# parents.append(parent)
	var exist: bool = false
	for p in parents:
		if p.x == parent.x and p.y == parent.y:
			exist = true
			break
	if not exist:
		parents.append(parent)

func get_parents() -> Array[MapRoomNode]:
	return parents

func has_parents() -> bool:
	return not parents.is_empty()

func has_edges() -> bool:
	return not edges.is_empty()

func add_edge(e: MapEdge, resort: bool = true):
	var unique: bool = true

	for edge in edges:
		if edge.equals(e):
			unique = false
			break
	if unique:
		edges.append(e)

		if resort:
			sort_edges()
func delete_node(e: MapEdge):
	if edges.has(e):
		edges.erase(e)
		return
	
	for edge in edges:
		if edge.equals(e):
			edges.erase(edge)
			return


func get_max_edge() -> MapEdge:
	sort_edges()
	return edges.back()

func get_min_edge() -> MapEdge:
	sort_edges()
	return edges.front()

func edge_comparator(a: MapEdge, b: MapEdge) -> bool:
	if a.dst.x < b.dst.x:
		return true
	if a.dst.x > b.dst.x:
		return false
	if a.dst.y < b.dst.y:
		return true
	if a.dst.y > b.dst.y:
		return false
	return true

func sort_edges() -> void:
	edges.assign(SortHelper.custom_stable_sort(edges, edge_comparator))
	# push_error("sort edges are not implemented")
