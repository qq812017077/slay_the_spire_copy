class_name CardTip
extends PanelContainer

static var ui_string: UIString = null
static var TEXT: Array

const BODY_TEXT_WIDTH = 280
static var energy_keywords = ["[R]", "[G]", "[B]", "[W]", "[E]"]
@export var keyword_name: RichTextLabel
@export var keyword_desc: RichTextLabel
var rendering_finished: bool = false
const colors = [AbstractCard.CardColor.RED, AbstractCard.CardColor.GREEN, AbstractCard.CardColor.BLUE, AbstractCard.CardColor.PURPLE,
			null]

func _ready() -> void:

	if ui_string == null:
		ui_string = CardGame.languagePack.get_ui_string("TipHelper")
		TEXT = ui_string.TEXT
	ThemeHelper.apply_tip_header_font_to_richlabel(keyword_name, {
		"default_color": ThemeHelper.GOLD_COLOR
	})
	ThemeHelper.apply_tip_body_font_to_richlabel(keyword_desc, {
		"default_color": Color(1.0, 0.9725, 0.8745, 1.0)
	})
	
	ThemeHelper.initialize_richtextlabel_style(keyword_name)
	ThemeHelper.initialize_richtextlabel_style(keyword_desc)
	keyword_name.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	keyword_desc.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	scale = Vector2(Settings.scale, Settings.scale)
	clear_content()

func clear_content() -> void:
	rendering_finished = false
	keyword_name.text = ""
	keyword_desc.text = ""

func set_content(keyword: String, desc: String) -> void:
	var idx = energy_keywords.find(keyword)
	if idx != -1:
		var taget_color = colors[idx]
		keyword_name.add_image(AbstractCard.get_cached_small_orb_texture_from_color(taget_color)
		, int(AbstractCard.CARD_ENERGY_IMG_WIDTH * 1.5), int(AbstractCard.CARD_ENERGY_IMG_WIDTH * 1.5))
		keyword_name.append_text(TEXT[0])
	else:
		keyword_name.append_text(keyword)
	
	RichTextHelper.render_smart_text(keyword_desc, desc, BODY_TEXT_WIDTH)
	rendering_finished = true
	size = Vector2(BODY_TEXT_WIDTH, keyword_name.get_content_height() + keyword_desc.size.y)

func safe_set_content(keyword: String, desc: String) -> void:
	var idx = energy_keywords.find(keyword)
	if idx != -1:
		var taget_color = colors[idx]
		keyword_name.call_deferred("add_image", AbstractCard.get_cached_small_orb_texture_from_color(taget_color)
		, int(AbstractCard.CARD_ENERGY_IMG_WIDTH * 1.5), int(AbstractCard.CARD_ENERGY_IMG_WIDTH * 1.5))
	else:
		keyword_name.call_deferred("append_text", keyword)
	
	RichTextHelper.safe_render_smart_text.call_deferred(keyword_desc, desc, BODY_TEXT_WIDTH)
	
	set_deferred("size", Vector2(BODY_TEXT_WIDTH, keyword_name.get_content_height() + keyword_desc.size.y))
	rendering_finished = true

func rendering_front(target_z_index: int = Global.TIP_Z_INDEX) -> void:
	z_index = target_z_index
	keyword_name.z_index = target_z_index
	keyword_desc.z_index = target_z_index
