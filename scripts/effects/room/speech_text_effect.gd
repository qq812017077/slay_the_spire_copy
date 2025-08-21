class_name SpeechTextEffect
extends AbstractGameEffect

var rttl: RichTextTransitionLabel = null
var target_global_pos: Vector2 = Vector2(0, 0)
var word_timer: float = 0.0
var msg: String
var appear_effect: RichTextTransitionLabel.AppearEffect
func _init(global_pos: Vector2, _duration: float, _msg: String, _appear_effect: RichTextTransitionLabel.AppearEffect):
    target_global_pos = global_pos
    duration = _duration
    msg = _msg
    appear_effect = _appear_effect
    

func _ready() -> void:
    rttl = RichTextTransitionLabel.new()
    add_child(rttl)
    ThemeHelper.apply_rich_label_font_style_with_settings(rttl, ThemeHelper.turn_num_settings, Color.WHITE)
    rttl.update_text_with_appear(msg, appear_effect)
    rttl.set_global_position(target_global_pos)

func _process(delta: float) -> void:
    duration -= delta

    word_timer -= delta
    if word_timer <= 0 and not rttl.is_done():
        word_timer = 0.03
        rttl.display_next_word()
    
    if duration < 0.3:
        rttl.modulate.a = MathHelper.lerp_snap(rttl.modulate.a, 0.0, delta * 8.0)

    if duration <= 0:
        is_done = true
        
