class_name TakeButton
extends Control

@export var icon: Sprite2D = null
@export var btn_name: Label = null

var btn: Button = null
var hover_flag = false


func _ready() -> void:
	btn = ButtonHelper.create_fit_button(btn_name, self)
	ThemeHelper.apply_label_font_style_with_settings(btn_name, ThemeHelper.button_label_settings, Color.WHITE)
	
	hide_button()
	btn.pressed.connect(_on_button_click)
func _process(_delta: float) -> void:
	if btn.is_hovered():
		if not hover_flag:
			hover_flag = true
			CardGame.sound.single_play("UI_HOVER")
		icon.self_modulate = Color.WHITE * 1.3
	else:
		hover_flag = false
		icon.self_modulate = Color.WHITE


func show_button_with_name(label_name: String) -> void:
	set_label(label_name)
	show_button()

func show_button() -> void:
	modulate.a = 1.0
	btn.disabled = false

func hide_button() -> void:
	btn.disabled = true
	modulate.a = 0.0

func set_label(text: String) -> void:
	btn_name.text = text

func _on_button_click() -> void:
	CardGame.sound.single_play("UI_CLICK_1").modify_volume(0.7)