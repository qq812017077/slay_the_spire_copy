class_name DialogOptionButton
extends Control

const ANIM_TIME: float = 0.5
const TEXT_ACTIVE_COLOR: Color = Color.WHITE
const TEXT_INACTIVE_COLOR: Color = Color(0.8, 0.8, 0.8, 1.0)
const TEXT_DISABLED_COLOR: Color = Color.FIREBRICK
const BUTTON_INACTIVE_COLOR: Color = Color(0.4, 0.4, 0.4, 1.0)
const BUTTON_DISABLED_COLOR: Color = Color(0.2, 0.25, 0.25, 1.0)

const TEXT_BODY_WIDTH: float = 890
const TEXT_BODY_HEIGHT: float = 77

const large_dialog_option_font_size: int = 30
const small_dialog_option_font_size: int = 26
@export var button_img: Sprite2D = null
@export var option_desc: RichTextLabel = null
var anim_timer: float = ANIM_TIME

var btn: Button = null
var is_disabled: bool = false
var slot: int = -1

func _ready() -> void:
	btn = ButtonHelper.create_fit_button(self)

	ThemeHelper.apply_rich_label_font_style_with_settings(option_desc, ThemeHelper.dialog_option_label_settings, Color.WHITE)

	btn.mouse_entered.connect(_on_button_mouse_entered)
	btn.mouse_exited.connect(_on_button_mouse_exited)
	btn.button_down.connect(_on_button_down)
	btn.button_up.connect(_on_button_up)
func _process(delta: float) -> void:
	update_animation(delta)

func update_animation(delta: float) -> void:
	if anim_timer > 0.0:
		anim_timer -= delta
		if anim_timer < 0.0:
			anim_timer = 0.0
		
		var alpha: float = CardGame.interpolation.apply_pow5in(0.0, 1.0, 1.0 - anim_timer / ANIM_TIME)
		option_desc.modulate.a = alpha
		button_img.modulate.a = alpha
	
func init_button(desc: String, _is_disabled: bool = false) -> void:
	option_desc.text = desc
	is_disabled = _is_disabled
	if is_disabled:
		desc = strip_color(desc)
		option_desc.modulate = TEXT_DISABLED_COLOR
		button_img.modulate = BUTTON_DISABLED_COLOR
	else:
		option_desc.modulate = TEXT_INACTIVE_COLOR
		button_img.modulate = BUTTON_INACTIVE_COLOR
	large_dialog_option()
	
	RichTextHelper.render_smart_text(option_desc, desc, TEXT_BODY_WIDTH)
	if option_desc.get_line_count() > 1:
		small_dialog_option()
		RichTextHelper.render_smart_text(option_desc, desc, TEXT_BODY_WIDTH)

	option_desc.position.y = int((TEXT_BODY_HEIGHT - option_desc.size.y) / 2)
func active() -> void:
	button_img.texture = ImageMaster.dialog_option_enable_button

func deactive() -> void:
	button_img.texture = ImageMaster.dialog_option_disable_button


func small_dialog_option() -> void:
	option_desc.add_theme_font_size_override("normal_font_size", small_dialog_option_font_size)

func large_dialog_option() -> void:
	option_desc.add_theme_font_size_override("normal_font_size", large_dialog_option_font_size)

func _on_button_mouse_entered() -> void:
	if not is_disabled:
		option_desc.modulate = TEXT_ACTIVE_COLOR
		button_img.modulate = Color.WHITE

func _on_button_mouse_exited() -> void:
	if not is_disabled:
		option_desc.modulate = TEXT_INACTIVE_COLOR
		button_img.modulate = BUTTON_INACTIVE_COLOR


func _on_button_down() -> void:
	if not is_disabled:
		button_img.scale = Vector2(0.98, 0.98)

func _on_button_up() -> void:
	if not is_disabled:
		button_img.scale = Vector2.ONE

static func strip_color(text: String) -> String:
	text = text.replace("#r", "")
	text = text.replace("#g", "")
	text = text.replace("#b", "")
	text = text.replace("#y", "")
	return text
