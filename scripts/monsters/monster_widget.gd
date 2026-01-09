class_name MonsterWidget
extends Control
# cached pool
static var monster_prefab: PackedScene = null
static var monster_widgets_pool: Array[MonsterWidget] = []

@export var animated_sprite: AnimatedSprite2D = null
@export var health_bar: HealthBar = null

var monster: AbstractMonster = null

static func _static_init() -> void:
	monster_prefab = load("res://scenes/slay_the_spire/monsters/monster.tscn")

static func preallocate() -> void:
	var widget: MonsterWidget
	for i in range(5):
		widget = monster_prefab.instantiate() as MonsterWidget
		monster_widgets_pool.append(widget)
		widget.process_mode = Node.PROCESS_MODE_DISABLED
		widget.hide()

func _ready() -> void:
	if animated_sprite == null:
		animated_sprite = $AnimatedSprite2D



func load_monster(_monster: AbstractMonster) -> void:
	monster = _monster
	animated_sprite.sprite_frames = monster.animation

	animated_sprite.play(monster.idle_animation)


static func allocate() -> MonsterWidget:
	return null

static func recycle(widget: MonsterWidget) -> void:
	pass
