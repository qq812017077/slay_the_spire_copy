class_name EventRoom
extends AbstractRoom

func _init() -> void:
    super(RoomPhase.EVENT, "E", ImageMaster.map_node_event, ImageMaster.map_node_event_outline)