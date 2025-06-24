extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var animated_sprite: AnimatedSprite2D = $IronSprite
	if animated_sprite != null:
		animated_sprite.play("idle")
	else:
		push_error("AnimatedSprite2D not found in player scene.")


