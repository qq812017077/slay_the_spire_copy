class_name SpeechBubble
extends AbstractGameEffect

enum BubbleType {SHOP, INFINITE}


func dismiss() -> void:
    duration = 0.3


static func create_infinite_speech_bubble(pos: Vector2, msg: String) -> SpeechBubble:
    return null

static func create_shop_speech_bubble(pos: Vector2, msg: String) -> SpeechBubble:
    return null