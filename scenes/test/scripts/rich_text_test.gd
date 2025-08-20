extends Node

var rich_text_transition_label: RichTextTransitionLabel

var text = "乞丐突然脱下了外套，原来他是 #b牧师 ！ NL @“你真是个善良的人，接受我的净化吧！”@ 他大声叫起来。 NL 老实说你有点不知道他是在开心还是在生气。"
func _ready():
    rich_text_transition_label = RichTextTransitionLabel.new()
    add_child(rich_text_transition_label)
    
    ThemeHelper.apply_rich_label_font_style_with_settings(rich_text_transition_label, ThemeHelper.char_desc_label_settings, ThemeHelper.CREAM_COLOR)
    rich_text_transition_label.update_body_text(text)
    rich_text_transition_label.size = Vector2(1000, 1000)
