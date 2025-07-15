class_name BossRoom
extends AbstractRoom


var boss_key: String
func _init() -> void:
    map_symbol = "B"
    type = RoomType.BOSS


func set_boss(_boss_key: String) -> void:
    boss_key = _boss_key
    map_img = ImageMaster.get_boss_img(boss_key)
    map_img_outline = ImageMaster.get_boss_img_outline(boss_key)