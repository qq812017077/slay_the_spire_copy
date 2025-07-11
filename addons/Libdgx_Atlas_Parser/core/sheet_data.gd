class_name SheetData
extends Object

var filename: String = ""
var size: Vector2i = Vector2i.ZERO
var sprites_data: Array[SpriteData] = []


func add_sprite(data) -> void:
	if data != null and data is SpriteData:
		sprites_data.append(data)
	else:
		push_error("Invalid sprite data provided.")

