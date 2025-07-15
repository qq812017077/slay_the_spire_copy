class_name MapEdge
extends Object

var src: Vector2i
var dst: Vector2i

var is_boss: bool

func _init(_src: Vector2i, _dst: Vector2i, _is_boss: bool = false) -> void:
    src = _src
    dst = _dst
    is_boss = _is_boss

func equals(other: MapEdge) -> bool:
    return src == other.src and dst == other.dst
