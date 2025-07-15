class_name SiblingRoomRule
extends AbstractRoomRule

const ROOM_TYPES = [AbstractRoom.RoomType.SHOP, AbstractRoom.RoomType.MONSTER, AbstractRoom.RoomType.ELITE, AbstractRoom.RoomType.TREASURE, AbstractRoom.RoomType.EVENT]
func satisify(node: MapRoomNode, room: AbstractRoom) -> bool:
	# 兄弟不为相同房间类型
	return ROOM_TYPES.find(room.type) == -1 or room.type != node.room.type

func is_all_satisify(nodes: Array[MapRoomNode], room: AbstractRoom) -> bool:
	for node in nodes:
		if node.has_room() and not satisify(node, room):
			return false
	return true
