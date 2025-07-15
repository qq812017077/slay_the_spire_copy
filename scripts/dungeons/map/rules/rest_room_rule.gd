class_name RestRoomRule
extends AbstractRoomRule

func satisify(node: MapRoomNode, room: AbstractRoom) -> bool:
    # 不是精英房，或者楼层高于4
    return room.type != AbstractRoom.RoomType.REST or (node.y > 4 and node.y < 13)
