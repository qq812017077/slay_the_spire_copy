class_name TextureDrawCommand
extends DrawCommand


var texture: AtlasTexture = null

func _init(_texture: Texture2D, _size: Vector2) -> void:
	super (DrawType.TEXTURE)
	texture = _texture
	size = _size
	token_text.add_object(texture, size, INLINE_ALIGNMENT_TO_BOTTOM, 1)


func draw_command(_canvas: CanvasItem, _location: Vector2) -> void:
	token_text.width = token_text.get_line_width() if size.x <= 0 else size.x
	token_text.draw(_canvas.get_canvas_item(), _location)
	var rect: Rect2 = token_text.get_object_rect(texture)
	var height_offset: float = (rect.size.y - texture.get_height()) / 2
	rect.position += _location
	rect.position += Vector2(0, 0 + height_offset)
	_canvas.draw_texture_rect(texture, rect, false)