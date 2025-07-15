class_name RestRoom
extends AbstractRoom


func _init() -> void:
    super (RoomPhase.INCOMPLETE, "R", ImageMaster.map_node_rest, ImageMaster.map_node_rest_outline)