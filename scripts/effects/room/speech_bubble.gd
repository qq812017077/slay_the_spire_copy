class_name SpeechBubble
extends AbstractGameEffect

const DISMISS_DURATION: float = 0.3
const SCALE_INIT_TIME: float = 0.3
const WAVY_DISTANCE: float = 2.0
const SHADOW_OFFSET: float = 16.0

const SPEECH_TEXT_L_X: float = -150
const SPEECH_TEXT_R_X: float = -150
const SPEECH_TEXT_Y: float = 126
enum BubbleType {SHOP, INFINITE, DEFAULT}

@export var bubble_sprite: Sprite2D
@export var bubble_shadow: Sprite2D


var target_texture: Texture2D
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

# text effect
var speech_text_effect: SpeechTextEffect = null
var text_offset: Vector2 = Vector2.ZERO
func _init() -> void:
	color = Color(0.8, 0.9, 0.9, 0.0)
	#set duration to max of float
	wavy_helper = 0.0

func _ready() -> void:
	name = msg + "_SpeechBubble"
	bubble_shadow.modulate = Color.BLACK
	
	bubble_sprite.texture = target_texture
	bubble_shadow.texture = target_texture

	if facing_right:
		bubble_sprite.flip_h = true
		bubble_shadow.flip_h = true
	
	speech_text_effect = SpeechTextEffect.new(pos + text_offset, duration, msg, RichTextTransitionLabel.AppearEffect.BUMP_IN)
	speech_text_effect.set_label_size(Vector2(300, target_texture.get_height()))
	
	if bubble_type == BubbleType.SHOP:
		CardGame.dungeon_main_screen.add_game_effect(speech_text_effect)
	else:
		z_index = Global.ROOM_Z_INDEX
		speech_text_effect.z_index = Global.ROOM_Z_INDEX
		CardGame.dungeon_main_screen.add_game_effect(speech_text_effect, false)

func _process(delta: float) -> void:
	duration -= delta
	
	if bubble_type == BubbleType.INFINITE:
		update_infinite_scale(delta)
		update_bubble(delta)
	elif bubble_type == BubbleType.SHOP:
		update_scale(delta)
		update_bubble(delta)
	elif bubble_type == BubbleType.DEFAULT:
		update_scale(delta)
		update_bubble(delta)
	if duration <= 0:
		is_done = true


func dismiss(instant: bool = false) -> void:
	duration = 0.0 if instant else DISMISS_DURATION
	speech_text_effect.duration = 0.0 if instant else DISMISS_DURATION

func update_bubble(delta: float) -> void:
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
	position = pos + Vector2(0, wavy_y)

func update_infinite_scale(delta: float) -> void:
	scaler_timer -= delta
	if scaler_timer <= 0:
		scaler_timer = 0.0
	scale.x = CardGame.interpolation.apply_circle_in(1.0, 0.5, scaler_timer / SCALE_INIT_TIME)
	scale.y = CardGame.interpolation.apply_swing_in(1.0, 0.8, scaler_timer / SCALE_INIT_TIME)


func update_scale(delta: float) -> void:
	scaler_timer -= delta
	if scaler_timer <= 0:
		scaler_timer = 0.0
	scale.x = CardGame.interpolation.apply_circle_in(1.0, 0.5, scaler_timer / SCALE_INIT_TIME)
	scale.y = CardGame.interpolation.apply_swing_in(1.0, 0.5, scaler_timer / SCALE_INIT_TIME)

func set_bubble_type(type: BubbleType, faceright: bool = true) -> void:
	bubble_type = type
	match bubble_type:
		BubbleType.SHOP:
			target_texture = ImageMaster.shop_speech_bubble_img
		BubbleType.INFINITE:
			target_texture = ImageMaster.speech_bubble_img
		BubbleType.DEFAULT:
			target_texture = ImageMaster.speech_bubble_img
	
	facing_right = faceright

static func create_infinite_speech_bubble(_pos: Vector2, _msg: String) -> SpeechBubble:
	var speech_bubble: SpeechBubble = CardGame.effect_library.speech_bubble_prefab.instantiate()
	speech_bubble.pos = _pos
	speech_bubble.msg = _msg
	speech_bubble.duration = 1e10
	speech_bubble.set_bubble_type(BubbleType.INFINITE)
	speech_bubble.text_offset = Vector2(-150.0, -256.0)
	return speech_bubble

static func create_shop_speech_bubble(_pos: Vector2, _msg: String, _duration: float = 4.0) -> SpeechBubble:
	var speech_bubble: SpeechBubble = CardGame.effect_library.speech_bubble_prefab.instantiate()
	speech_bubble.pos = _pos + Vector2(0, 220.0)
	speech_bubble.msg = _msg
	speech_bubble.duration = _duration
	var is_right = randf() > 0.5
	speech_bubble.set_bubble_type(BubbleType.SHOP, is_right)
	if is_right:
		speech_bubble.text_offset = Vector2(SPEECH_TEXT_R_X, -256.0)
	else:
		speech_bubble.text_offset = Vector2(SPEECH_TEXT_L_X, -256.0)
	return speech_bubble

static func create_speech_bubble(_pos: Vector2, _msg: String, _duration: float, facing_player: bool = false) -> SpeechBubble:
	var speech_bubble: SpeechBubble = CardGame.effect_library.speech_bubble_prefab.instantiate()
	if facing_player:
		speech_bubble.pos = _pos + Vector2(50, 0.0)
	else:
		speech_bubble.pos = _pos + Vector2(450, 0.0)
	speech_bubble.msg = _msg
	speech_bubble.duration = _duration
	speech_bubble.set_bubble_type(BubbleType.DEFAULT, facing_player)
	speech_bubble.text_offset = Vector2(-150.0, -256.0)
	return speech_bubble
