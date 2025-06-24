class_name AtlasRegion
extends Object

var name: String = ""
var texture: Texture2D = null
var rotate: bool = false
var xy: Vector2i = Vector2i.ZERO
var size: Vector2i = Vector2i.ZERO
var orig: Vector2i = Vector2i.ZERO
var offset: Vector2i = Vector2i.ZERO
var index: int = -1

func _init(_texture: Texture2D) -> void:
	texture = _texture

func set_attr(key, value):
	match key:
		'rotate':
			rotate = value == "true"
		'xy':
			xy = Vector2i(value.split(',')[0].to_int(), value.split(',')[1].to_int())
		'size':
			size = Vector2i(value.split(',')[0].to_int(), value.split(',')[1].to_int())
		'offset':
			offset = Vector2i(value.split(',')[0].to_int(), value.split(',')[1].to_int())
		'orig':
			orig = Vector2i(value.split(',')[0].to_int(), value.split(',')[1].to_int())
		'index':
			if value != '-1':
				name += '.' + value
		_:
			push_error("Unknown attribute key: %s" % key)
