class_name MouseCursor
extends Control

const normal_cursor_path: String = "res://arts/slay_the_spire/images/ui/cursors/gold2.png"
const clicked_cursor_path: String = "res://arts/slay_the_spire/images/ui/cursors/gold2-clicked.png"
const mapGlass_path: String = "res://arts/slay_the_spire/images/ui/cursors/magGlass2.png"

var normal_cursor: Texture2D
var clicked_cursor: Texture2D
var is_pressed: bool = false
func _ready() -> void:
    normal_cursor = load(normal_cursor_path)
    clicked_cursor = load(clicked_cursor_path)
    
    Input.set_custom_mouse_cursor(normal_cursor)

func _process(_delta: float) -> void:
    var pressed = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
    if not is_pressed and pressed:
        Input.set_custom_mouse_cursor(clicked_cursor)
    elif is_pressed and not pressed:
        Input.set_custom_mouse_cursor(normal_cursor)
    
    is_pressed = pressed