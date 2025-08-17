class_name InteractableTorchEffect
extends AbstractParticleEffect

enum TorchType {SMALL, MEDIUM, LARGE}

@export var torch_type: TorchType = TorchType.MEDIUM
@export var input_checker: Control = null

func _ready() -> void:
	super()
	match torch_type:
		TorchType.SMALL:
			scale = Vector2.ONE * 0.6
		TorchType.MEDIUM:
			scale = Vector2.ONE * 1
		TorchType.LARGE:
			scale = Vector2.ONE * 1.4

	input_checker.gui_input.connect(_on_gui_input)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
			reverse()
