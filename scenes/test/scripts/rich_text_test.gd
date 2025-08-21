extends Node

var rich_text_transition_label: RichTextTransitionLabel

var text = "乞丐突然脱下了外套，原来他是 #b牧师 ！ NL @“你真是个善良的人，接受我的净化吧！”@ 他大声叫起来。 NL 老实说你有点不知道他是在开心还是在生气。"

var word_timer: float = 0
func _ready():
    rich_text_transition_label = RichTextTransitionLabel.new()
    add_child(rich_text_transition_label)
    
    ThemeHelper.apply_rich_label_font_style_with_settings(rich_text_transition_label, ThemeHelper.char_desc_label_settings, ThemeHelper.CREAM_COLOR)
    rich_text_transition_label.update_text_with_appear(text, RichTextTransitionLabel.AppearEffect.BUMP_IN)
    rich_text_transition_label.size = Vector2(1000, 1000)

func _process(delta: float) -> void:
    # if Input.is_key_pressed(KEY_ENTER):
    #     rich_text_transition_label.display_next_word()
    word_timer -= delta
    if word_timer < 0 and not rich_text_transition_label.is_done():
        if Settings.FAST_MODE:
            word_timer = 0.005
        else:
            word_timer = 0.02
        rich_text_transition_label.display_next_word()
