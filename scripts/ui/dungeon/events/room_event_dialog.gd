class_name RoomEventDialog
extends EventDialog
const PANEL_COLOR: Color = Color(1, 1, 1, 0.0)


@export var animated_npc: AnimatedSprite2D = null


func clear_dialog() -> void:
	clear_dialog_options()