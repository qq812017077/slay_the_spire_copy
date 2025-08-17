class_name ShopRoom
extends AbstractRoom

func _init() -> void:
    super(RoomPhase.INCOMPLETE, "$", ImageMaster.map_node_merchant, ImageMaster.map_node_merchant_outline)


func on_player_entry():
    CardGame.music.play_temp_bgm("SHOP")