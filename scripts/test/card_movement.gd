extends Control

@export var line: Line2D
var card_widget: CardWidget
@export_range(0.0, 1.0) var t: float = 0.0

var crs: CatmullRomSpline = CatmullRomSpline.new()
func _ready() -> void:
    card_widget = CardWidget.allocate(StrikeRed.new(), self, 0.1)
    card_widget.set_position(Vector2(900, 400))

    crs.load_points(line.points)

func _process(_delta: float) -> void:
    if card_widget == null:
        return
    var target_pos: Vector2 = get_global_mouse_position()
    var pos: Vector2 = card_widget.get_center_position()
    var target_dir: Vector2 = target_pos - pos
    target_dir = target_dir.normalized()
    var target_angle: float = target_dir.angle()

    card_widget.rotation = target_angle + PI / 2

    var pcoord = crs.value_at(t)
    # var pcoord = CatmullRomSpline._catmull_rom_v2(line.points[0], line.points[1], line.points[2], line.points[3], t)
    # print(pcoord)
    card_widget.set_position(pcoord - card_widget.get_size() / 2)