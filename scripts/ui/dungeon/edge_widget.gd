class_name EdgeWidget
extends Control

static var ICON_RADIUS: float = 29
static var SPACE_X: float = 128
static var SPACING: float = 17
const DOT_JITTER: float = 4

var edge: MapEdge = null
var dots: Array[Sprite2D] = []

var src_pos: Vector2 = Vector2.ZERO
var dst_pos: Vector2 = Vector2.ZERO


func set_endpoints(_src: RoomNodeWidget, _dst: RoomNodeWidget, is_boss: bool = false) -> void:
    src_pos = _src.get_actual_position()
    dst_pos = _dst.get_actual_position()

    # edge_widget.position = Vector2.ZERO
    # print("src[{0}] pos:{1}, dst[{2}] pos:{3}".format([src_widget.name, src_widget.position, dst_widget.name, dst_widget.position]))
    var dir = dst_pos - src_pos
    # 计算弧度
    var angle = dir.angle() + deg_to_rad(90)
    var dist: float = dir.length()
    var START = SPACING * randf() / 2
    var tmp_radius: float = 164.0 if is_boss else ICON_RADIUS
    
    var i = START + tmp_radius
    var first = true
    while i < (dist - ICON_RADIUS):
        dir = dir.normalized() * (dist - i)
        var dot = Sprite2D.new()
        add_child(dot)
        dot.position = src_pos + dir
        dot.rotation = angle
        dot.texture = ImageMaster.map_dot
        if not first && i <= dist - ICON_RADIUS - SPACING:
            # add jitter:
            dot.position += Vector2(randf_range(-DOT_JITTER, DOT_JITTER), randf_range(-DOT_JITTER, DOT_JITTER))
            dot.rotation_degrees += randi_range(-10, 10)
        dots.append(dot)
        first = false

        i += SPACING

    # print("dot count:", dots.size())