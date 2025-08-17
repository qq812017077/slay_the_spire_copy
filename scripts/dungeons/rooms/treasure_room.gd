class_name TreasureRoom
extends AbstractRoom

enum ChestType {
    SMALL, MEDIUM, LARGE, BOSS
}

var chest_type: ChestType = ChestType.SMALL
func _init() -> void:
    super(RoomPhase.INCOMPLETE, "T", ImageMaster.map_node_treasure, ImageMaster.map_node_treasure_outline)
