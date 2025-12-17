class_name MonsterWidget
extends Control

@export var animated_sprite: AnimatedSprite2D = null
@export var shoulder: Sprite2D = null
@export var health_bar: HealthBar = null

var monster: AbstractMonster = null

func _ready() -> void:
	if animated_sprite == null:
		animated_sprite = $AnimatedSprite2D
	

func load_monster(_monster: AbstractMonster) -> void:
	monster = _monster
	animated_sprite.sprite_frames = monster.animation

	animated_sprite.play(monster.idle_animation)