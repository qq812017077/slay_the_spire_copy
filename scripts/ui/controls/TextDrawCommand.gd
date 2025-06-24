class_name TextDrawCommand
extends Object
enum DescTextType{NORMAL, KEYWORD, ENERGY}

var desc_type: DescTextType
var text: String = ""
var size: Vector2 = Vector2.ZERO
var draw_shadow: bool = false
var token_text = TextLine.new()
var texture : AtlasTexture = null
var desc_color: Color
func _init(_desc_type: DescTextType, _text: String, _draw_shadow: bool, _size: Vector2, color: AbstractCard.CardColor) -> void:
	desc_type = _desc_type
	text = _text
	draw_shadow = _draw_shadow
	size = _size
	if is_energy():
		texture = CardWidget.get_cached_orb_texture(color)
		token_text.add_object(texture, size, INLINE_ALIGNMENT_TO_BOTTOM,1)
	else:
		token_text.add_string(text, ThemeHelper.normal_font_zhs, ThemeHelper.card_desc_font_size)
		desc_color = ThemeHelper.card_desc_keyword_color if is_keyword() else ThemeHelper.card_desc_normal_color
	
func is_keyword() ->bool:
	return desc_type == DescTextType.KEYWORD
	
func is_energy() -> bool:
	return desc_type == DescTextType.ENERGY
	