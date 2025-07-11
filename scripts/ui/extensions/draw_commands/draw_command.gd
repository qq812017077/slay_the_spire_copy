class_name DrawCommand
extends Object

enum DrawType{TEXT, KEYWORD, TEXTURE}

var type: DrawType
var token_text = TextLine.new()
var size: Vector2 = Vector2.ZERO

func _init(_type: DrawType) -> void:
	type = _type
	
func draw_command(_canvas: CanvasItem, _location: Vector2) -> void:
	pass