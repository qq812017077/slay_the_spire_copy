class_name SpeechBubble
extends AbstractGameEffect

const DISMISS_DURATION: float = 0.3
const SCALE_INIT_TIME: float = 0.3
const WAVY_DISTANCE: float = 2.0
const SHADOW_OFFSET: float = 16.0

enum BubbleType {SHOP, INFINITE, DEFAULT}

@export var bubble_sprite: Sprite2D
@export var bubble_shadow: Sprite2D
@export var bubble_text: Label

var bubble_type: BubbleType
var pos: Vector2
var msg: String

var scaler_timer: float = SCALE_INIT_TIME
var facing_right: bool = true

# wave
var wavy_helper: float = 0.0
var wavy_y: float = 0.0

# shadow
var shadow_offset: float = 0.0

func _init() -> void:
	color = Color(0.8, 0.9, 0.9, 0.0)
	#set duration to max of float
	duration = 1e10
	wavy_helper = 0.0

func _ready() -> void:
	bubble_shadow.modulate = Color.BLACK

func _process(delta: float) -> void:
	duration -= delta
	
	if bubble_type == BubbleType.INFINITE:
		update_infinite(delta)
	
	if duration <= 0:
		is_done = true

	
func dismiss() -> void:
	duration = DISMISS_DURATION

func update_infinite(delta: float) -> void:
	update_scale(delta)
	wavy_helper += delta * 4.0
	wavy_y = sin(wavy_helper) * WAVY_DISTANCE

	shadow_offset = MathHelper.lerp_snap(shadow_offset, SHADOW_OFFSET, duration * 4.0)
	if duration > DISMISS_DURATION:
		color.a = MathHelper.lerp_snap(color.a, 1.0, delta * 12.0)
	else:
		color.a = MathHelper.lerp_snap(color.a, 0.0, delta * 12.0)

	bubble_shadow.modulate.a = color.a / 4.0
	bubble_shadow.offset = Vector2(shadow_offset, shadow_offset)
	bubble_sprite.modulate = color

func update_scale(delta: float) -> void:
	scaler_timer -= delta
	if scaler_timer <= 0:
		scaler_timer = 0.0
	scale.x = CardGame.interpolation.apply_circle_in(1.0, 0.5, scaler_timer / SCALE_INIT_TIME)
	scale.y = CardGame.interpolation.apply_circle_in(1.0, 0.8, scaler_timer / SCALE_INIT_TIME)

func set_bubble_type(type: BubbleType) -> void:
	bubble_type = type
	match bubble_type:
		BubbleType.SHOP:
			bubble_sprite.texture = ImageMaster.shop_speech_bubble_img
		BubbleType.INFINITE:
			bubble_sprite.texture = ImageMaster.speech_bubble_img
	
	
static func create_infinite_speech_bubble(_pos: Vector2, _msg: String) -> SpeechBubble:
	var speech_bubble: SpeechBubble = CardGame.effect_library.speech_bubble_prefab.instantiate()
	speech_bubble.pos = _pos
	speech_bubble.msg = _msg
	speech_bubble.set_bubble_type(BubbleType.INFINITE)
	return speech_bubble

static func create_shop_speech_bubble(_pos: Vector2, _msg: String) -> SpeechBubble:
	var speech_bubble: SpeechBubble = CardGame.effect_library.speech_bubble_prefab.instantiate()
	speech_bubble.pos = _pos
	speech_bubble.msg = _msg
	speech_bubble.set_bubble_type(BubbleType.SHOP)
	return speech_bubble
