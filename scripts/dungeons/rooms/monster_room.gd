class_name MonsterRoom
extends AbstractRoom

func _init() -> void:
    super(RoomPhase.COMBAT, "M", ImageMaster.map_node_enemy, ImageMaster.map_node_enemy_outline)