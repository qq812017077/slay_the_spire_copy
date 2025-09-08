class_name AbstractPanel
extends Control

var show_pos: Vector2 = Vector2(0, 0)
var hide_pos: Vector2 = Vector2(0, 0)

var target_pos : Vector2
var is_hidden: bool = false
var is_moving: bool = false



func _process(delta: float) -> void:
    update_position(delta)

    update(delta)
func update_position(delta: float) -> void:
    if position.distance_to(target_pos) > 0.1:
        position = MathHelper.vec2_lerp_snap(position, target_pos, delta * 7.0)
        is_moving = true
    else:
        is_moving = false
func update(_delta: float) -> void:
    pass

func set_pos(_show_pos: Vector2, _hide_pos: Vector2) -> void:
    self.show_pos = _show_pos
    self.hide_pos = _hide_pos

func show_panel() -> void:
    if not is_hidden:
        return
    target_pos = show_pos
    is_moving = false
    is_hidden = false



func hide_panel(instant: bool = false) -> void:
    if is_hidden:
        return

    if instant:
        position = hide_pos
    target_pos = hide_pos
    is_moving = false
    is_hidden = true


func load_player(_player: AbstractPlayer) -> void:
    pass