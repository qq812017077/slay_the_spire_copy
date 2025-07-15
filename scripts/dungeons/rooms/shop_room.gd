class_name ShopRoom
extends AbstractRoom

func _init() -> void:
    super(RoomPhase.COMPLETE, "$", ImageMaster.map_node_merchant, ImageMaster.map_node_merchant_outline)