class_name EndTurnButton
extends Control


static var ui_string: UIString = null
static var TEXT: Array = []
static var END_TURN_MSG: String
static var ENEMY_TURN_MSG: String
const DISABLE_COLOR: Color = Color(0.7, 0.7, 0.7, 1.0)
const SHOW_POS: Vector2 = Vector2(1640.0, 1080.0 - 210.0)
const HIDE_POS: Vector2 = Vector2(1640.0 + 500.0, 1080.0 - 210.0)
@export var glow_button_img: Texture2D
@export var button_img: Texture2D
@export var label: Label
@export var hover_sprite: Sprite2D
@export var end_turn_sprite: Sprite2D
@export var end_turn_blend_sprite: Sprite2D
@export_group("Glow Effect")
@export var glow_list_container: Control
@export var glow_effect_prefab: PackedScene

var button: Button = null
var is_hidden: bool = false
var enabled: bool = false
var cur_pos: Vector2 = Vector2(0.0, 0.0)
var target_pos: Vector2 = Vector2(0.0, 0.0)

var glow_timer: float = 0.0
var is_glowing: bool = false
var glow_list: Array = []
var can_use: bool = true

var text_color: Color = Color.WHITE
func _ready() -> void:
	if ui_string == null:
		ui_string = CardGame.languagePack.get_ui_string("End Turn Button")
		TEXT = ui_string.TEXT
		END_TURN_MSG = TEXT[0]
		ENEMY_TURN_MSG = TEXT[1]
	
	button = ButtonHelper.create_fit_button(label, self)
	# ThemeHelper.apply_button_font_style_with_color(button, {"font_color": Color.hex(0xffeda7ff)})
	ThemeHelper.apply_label_font_style_with_settings(label, ThemeHelper.panel_end_turn_label_settings, Color.WHITE)

	end_turn_blend_sprite.material = MaterialLibrary.add_material
	end_turn_blend_sprite.modulate = ThemeHelper.HALF_TRANSPARENT_WHITE_COLOR
	hide_button(true)
	button.pressed.connect(_on_button_click)
	button.mouse_entered.connect(_on_mouse_enter)

func can_click() -> bool:
	return enabled and can_use and not is_hidden

func _process(delta: float) -> void:
	glow(delta)

	cur_pos = MathHelper.vec2_lerp_snap(cur_pos, target_pos, 9.0 * delta)
	position = cur_pos

	if not can_use or not enabled:
		label.modulate = ThemeHelper.CREAM_COLOR if label.text == ENEMY_TURN_MSG else Color.LIGHT_GRAY
	else:
		if button.is_hovered():
			label.modulate = Color.CYAN
		else:
			label.modulate = ThemeHelper.GOLD_COLOR if is_glowing else ThemeHelper.CREAM_COLOR

	hover_sprite.visible = can_click() and button.is_hovered()
	var color: Color = Color.WHITE
	if enabled:
		color = DISABLE_COLOR if not can_use else Color.WHITE
		end_turn_sprite.material = null
	else:
		end_turn_sprite.material = MaterialLibrary.gray_material
	end_turn_sprite.modulate = color

	end_turn_blend_sprite.visible = can_click() and button.is_hovered()

func glow(delta: float) -> void:
	if is_glowing and not is_hidden:
		if glow_timer < 0.0:
			var glow_effect: EndTurnGlowEffect = glow_effect_prefab.instantiate()
			glow_list.append(glow_effect)
			glow_list_container.add_child(glow_effect)
			glow_timer = 1.2
		else:
			glow_timer -= delta

	for glow_effect : EndTurnGlowEffect in glow_list:
		if glow_effect.is_done:
			glow_list.erase(glow_effect)
			glow_effect.queue_free()

func update_text(text: String) -> void:
	label.text = text

func enable() -> void:
	enabled = true
	update_text(END_TURN_MSG)

func disable(is_enemy_turn: bool = false) -> void:
	enabled = false
	is_glowing = false

	if is_enemy_turn:
		update_text(ENEMY_TURN_MSG)
		CardGame.sound.single_play("END_TURN")
	else:
		update_text(END_TURN_MSG)


func show_button(enable_button: bool = true) -> void:
	if not is_hidden:
		return
	
	# push_error("show")
	is_hidden = false
	button.disabled = false
	target_pos = SHOW_POS
	if is_glowing:
		glow_timer = -1.0
	
	if enable_button:
		enable()
	else:
		disable()


func hide_button(instant: bool = false) -> void:
	if is_hidden:
		return
	# push_error("hiden")
	is_hidden = true
	button.disabled = true
	target_pos = HIDE_POS
	if instant:
		cur_pos = target_pos
	
	if is_glowing:
		glow_timer = -1.0
	

func _on_button_click() -> void:
	# var can_use: bool = not CardGame.dungeon_main_screen.dungeon_room_screen.combat_ui.is_drag_successful()
	if can_click():
		disable(true)
		CardGame.sound.single_play("UI_CLICK_1").modify_volume(0.7)
	
func _on_mouse_enter() -> void:
	if can_click():
		CardGame.sound.single_play("UI_HOVER")