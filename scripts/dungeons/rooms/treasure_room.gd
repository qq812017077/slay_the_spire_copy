class_name TreasureRoom
extends AbstractRoom

func _init() -> void:
    super(RoomPhase.COMPLETE, "T", ImageMaster.map_node_treasure, ImageMaster.map_node_treasure_outline)