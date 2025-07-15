class_name ParentRoomRule
extends AbstractRoomRule

const SPECIAL_ROOM_TYPES = [AbstractRoom.RoomType.SHOP, AbstractRoom.RoomType.ELITE, AbstractRoom.RoomType.TREASURE, AbstractRoom.RoomType.REST]
func satisify(node: MapRoomNode, room: AbstractRoom) -> bool:
	# 父子不为相同的特殊房间类型
	return SPECIAL_ROOM_TYPES.find( room.type ) == -1 or room.type != node.room.type

func is_all_satisify(nodes: Array[MapRoomNode], room: AbstractRoom) -> bool:
	for node in nodes:
		if not satisify(node, room):
			return false
	return true
