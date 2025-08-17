class_name ScreenButton
extends Control


enum ScreenButtonType {CONFIRM, CANCEL}

const SHOW_X = 0
const HIDE_X = SHOW_X - 400

@export var button_type: ScreenButtonType
@export var button: Button
@export var button_tex: TextureRect
@export var outline_tex: TextureRect

var glow_alpha: float = 0.0
var glow_color = Color.GOLD
var target_offset_x: float = 0.0
var current_offset_x: float = 0.0

var starting_pos: Vector2

var is_hidden: bool = false
var hover_flag: bool = false
var timer: Timer = null
var hide_timer: Timer = null
func _ready() -> void:
	ThemeHelper.clean_button_style(button)
	ThemeHelper.apply_button_font_style_with_color(button, {"font_color": Color.hex(0xffeda7ff)})
	starting_pos = position
	
	hide_button(true)
	button.pressed.connect(_on_button_click)
	

func _process(delta: float) -> void:
	if button.is_hovered():
		if not hover_flag:
			hover_flag = true
			CardGame.sound.single_play("UI_HOVER")
		button_tex.self_modulate = Color.WHITE * 1.5
	else:
		hover_flag = false
		button_tex.self_modulate = Color.WHITE

	
	glow_alpha += delta * 2.0
	var tmp = cos(abs(glow_alpha))
	if tmp < 0:
		glow_color.a = - tmp / 2 + 0.3
	else:
		glow_color.a = tmp / 2 + 0.3
	outline_tex.self_modulate = glow_color

	if current_offset_x != target_offset_x:
		current_offset_x = MathHelper.lerp_snap(current_offset_x, target_offset_x, delta * 9.0)

	if button_type == ScreenButtonType.CONFIRM:
		position = starting_pos - Vector2(current_offset_x, 0)
	else:
		position = starting_pos + Vector2(current_offset_x, 0)

func hide_button(instant: bool = false) -> void:
	if timer != null:
		timer.stop()
	
	if is_hidden:
		return
	# push_error("hiden")
	is_hidden = true
	button.disabled = true
	target_offset_x = HIDE_X
	if instant:
		current_offset_x = HIDE_X
		modulate.a = 0.0
	else:
		if hide_timer == null:
			hide_timer = Timer.new()
			hide_timer.name = "ScreenButtonHideTimer"
			add_child(hide_timer)
			hide_timer.timeout.connect(func() -> void: modulate.a = 0.0)
		hide_timer.start(1.0)

func show_button_delay(delay_time_sec: float = 0.5) -> void:
	if timer == null:
		timer = Timer.new()
		timer.name = "ScreenButtonTimer"
		add_child(timer)
		timer.timeout.connect(show_button)
	timer.start(delay_time_sec)

func show_button_with_name(label_name: String) -> void:
	set_label(label_name)
	show_button()

func show_button() -> void:
	# push_error("show_button")
	if hide_timer != null and not hide_timer.is_stopped():
		hide_timer.stop()
	
	modulate.a = 1.0
	if not is_hidden:
		return
	# push_error("show")
	is_hidden = false
	button.disabled = false
	target_offset_x = SHOW_X

func set_label(text: String) -> void:
	button.text = text
func _on_button_click() -> void:
	CardGame.sound.single_play("UI_CLICK_1").modify_volume(0.7)
