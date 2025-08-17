class_name DynamicBanner
extends Control

const Y_OFFSET: float = 50
const ANIM_TIME: float = 0.5
const IDLE_COLOR: Color = Color(0.7, 0.7, 0.7, 1)
const TEXT_SHOW_COLOR: Color = Color(0.9, 0.9, 0.9, 1)
const FADE_COLOR: Color = Color(1, 1, 1, 0)

const BANNER_Y: float = 239
@export var icon: Sprite2D = null
@export var label: Label = null

var anim_timer: float = 0.0
var is_show: bool = false
var is_moving: bool = false

var icon_tint: TintEffect = TintEffect.new()
var text_tint: TintEffect = TintEffect.new()

var y: float = 0.0
var start_y: float = 0.0
var target_y: float = 0.0
var text_scale: float = 1.0

func _ready() -> void:
    name = "Dynamic Banner"
    position = Vector2(960.0, BANNER_Y)
    if icon == null:
        icon = Sprite2D.new()
        add_child(icon)
    if label == null:
        label = Label.new()
        add_child(label)
    icon.texture = ImageMaster.SELECT_BANNER

    ThemeHelper.apply_label_font_style_with_settings(label, ThemeHelper.lose_power_label_settings, Color.WHITE)
    icon_tint.color.a = 0.0
    text_tint.color.a = 0.0

    label.pivot_offset = label.size / 2.0


func _process(delta: float) -> void:
    icon_tint.update(delta)
    text_tint.update(delta)

    if is_show:
        anim_timer -= delta
        if anim_timer < 0.0:
            anim_timer = 0.0
            is_moving = false
        else:
            y = CardGame.interpolation.apply_swing_out(start_y, target_y, (ANIM_TIME - anim_timer) / ANIM_TIME)
            text_scale = CardGame.interpolation.apply_swing_out(0, 1.2, (ANIM_TIME - anim_timer) / ANIM_TIME)
            if text_scale < 0.0:
                text_scale = 0.01
    
    icon.self_modulate = icon_tint.color
    label.self_modulate = text_tint.color
    self.position.y = y
    self.label.scale = Vector2(text_scale, text_scale)

func show_banner(content: String, instant: bool = false) -> void:
    show_banner_at(BANNER_Y, content, instant)

func show_banner_at(_y: float, content: String, instant: bool = false) -> void:
    if instant:
        anim_timer = 0.0
        is_moving = false
        y = _y
        text_scale = 0.25
    else:
        anim_timer = ANIM_TIME
        is_moving = true
        start_y = _y + Y_OFFSET
        y = _y + Y_OFFSET
        text_scale = 1.2
    is_show = true
    target_y = _y

    label.text = content
    var text_size: Vector2 = ThemeHelper.lose_power_label_settings.font.get_string_size(label.text, HORIZONTAL_ALIGNMENT_LEFT, -1, ThemeHelper.lose_power_label_settings.font_size)
    label.size.x = text_size.x
    label.position.x = - text_size.x / 2
    label.position.y = -50
    label.pivot_offset.x = text_size.x / 2
    icon_tint.set_target_color(IDLE_COLOR, 9)
    text_tint.set_target_color(TEXT_SHOW_COLOR, 9)
    

func hide_banner(instant: bool = false) -> void:
    is_show = false
    is_moving = false

    if instant:
        icon_tint.color = FADE_COLOR
        text_tint.color = FADE_COLOR
    icon_tint.set_target_color(FADE_COLOR, 18)
    text_tint.set_target_color(FADE_COLOR, 18)