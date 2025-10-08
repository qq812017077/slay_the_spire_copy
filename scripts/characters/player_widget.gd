class_name PlayerWidget
extends Control

@export var animated_sprite: AnimatedSprite2D = null
@export var shoulder: Sprite2D = null
@export var health_bar: HealthBar = null
var player: AbstractPlayer = null
var target_shoulder_pos_x: float = 0

var damaged_this_combat: int = 0
var game_hand_size: int = 0
var is_dragging_card: bool = false
var is_hovering_drop_zone: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if animated_sprite == null:
		animated_sprite = $AnimatedSprite2D
	
	# if animated_sprite != null:
	# 	animated_sprite.play("idle")
	# else:
	# 	push_error("AnimatedSprite2D not found in player scene.")


func _process(delta: float) -> void:
	shoulder.position.x = MathHelper.lerp_snap(shoulder.position.x, target_shoulder_pos_x, delta * 5)

func load(_player: AbstractPlayer) -> void:
	player = _player
	
	play_idle_animation()

func play_idle_animation() -> void:
	animated_sprite.play(player.idle_animation)

func play_hit_animation() -> void:
	animated_sprite.play(player.hit_animation)

func get_into_combat() -> void:
	animated_sprite.visible = true
	shoulder.visible = false
	CardGame.action_manager.on_combat_start()
	pre_battle_preparation()

func pre_battle_preparation() -> void:
	player.pre_combat_begin()
	game_hand_size = player.master_hand_size

func get_into_campfire(fade_in: bool = true) -> void:
	animated_sprite.visible = false
	shoulder.visible = true
	shoulder.texture = player.shoulder_img
	if fade_in:
		shoulder.position.x = -300

	# shoulder.texture = player.shoulder2_img

func get_into_event() -> void:
	animated_sprite.visible = false
	shoulder.visible = false


func reset() -> void:
	health_bar.hide_health_bar()
	player.orbs.clear()
	player.hand.clear()
	player.powers.clear()
	player.draw_pile.clear()
	player.discard_pile.clear()
	player.exhaust_pile.clear()
	damaged_this_combat = 0