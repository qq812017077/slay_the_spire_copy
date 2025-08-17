class_name GenericEventDialog
extends EventDialog

const PANEL_COLOR: Color = Color(1, 1, 1, 0.0)
const TITLE_COLOR: Color = Color(1.0, 0.835, 0.39, 1.0)
const BORDER_COLOR: Color = Color(0.0, 0.0, 0.0, 0.0)
const IMG_COLOR: Color = Color(1.0, 1.0, 1.0, 0.0)
const ANIM_SPEED: float = 0.5

@export var event_background_img: Sprite2D = null
@export var img: TextureRect = null
@export var img_frame: Sprite2D = null
@export var title: Label = null
var is_show: bool = false
var animate_timer: float = 0.0

var bg_alpha: float = 0.0
func _ready() -> void:
	super._ready()
	ThemeHelper.apply_label_font_style_with_settings(title, ThemeHelper.lose_power_label_settings, TITLE_COLOR)
	clear_dialog()


func animate_in(delta: float) -> void:
	if is_show:
		animate_timer -= delta
		if animate_timer < 0.0:
			animate_timer = 0.0
		event_background_img.modulate.a = MathHelper.lerp_snap(event_background_img.modulate.a, 1.0, delta * 3.0)

		if event_background_img.modulate.a > 0.8:
			title.modulate.a = MathHelper.lerp_snap(title.modulate.a, 1.0, delta * 3.0)
			img_frame.modulate.a = title.modulate.a
			if title.modulate.a > 0.8:
				img.modulate.a = MathHelper.lerp_snap(title.modulate.a, 1.0, delta * 3.0)

func show_dialog(title_content: String, text_content: String) -> void:
	is_show = true
	title.text = title_content
	update_body_text(text_content)
	animate_timer = 0.125 if Settings.FAST_MODE else 0.5


func hide_dialog() -> void:
	is_show = false

func clear_dialog() -> void:
	is_show = false
	animate_timer = 0.0
	img.modulate = IMG_COLOR
	img_frame.modulate = BORDER_COLOR
	event_background_img.modulate = PANEL_COLOR
	title.modulate.a = 0.0
	clear_dialog_options()
	

func load_image(tex: Texture2D) -> void:
	img.texture = tex




func clear_image() -> void:
	img.texture = null
