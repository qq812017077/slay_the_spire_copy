class_name TreasureUI
extends Control

static var ui_string: UIString = null
static var TEXT: Array = []

static func initialize():
	ui_string = CardGame.languagePack.get_ui_string("TreasureRoom")
	TEXT = ui_string.TEXT

@export var chest_sprite: Sprite2D = null
@export var chest_btn: Button = null
@export var boss_effect_prefab: PackedScene = null
@export var normal_effect_prefab: PackedScene = null
var chest_img: Texture2D = null
var opened_chest_img: Texture2D = null

var is_opened: bool = false:
	set = _set_is_opened
var relic: AbstractRelic = null
var chest_type: TreasureRoom.ChestType = TreasureRoom.ChestType.SMALL

var particle: AbstractParticleEffect = null
var shine_effect: ChestShineEffect = null
func _ready() -> void:
	ThemeHelper.clean_button_style(chest_btn)
	chest_btn.mouse_entered.connect(_on_chest_mouse_entered)
	chest_btn.mouse_exited.connect(_on_chest_mouse_exitd)
	chest_btn.pressed.connect(_on_chest_clicked)


func open(room: TreasureRoom) -> void:
	if visible:
		return
	visible = true
	if CardGame.dungeon_main_screen:
		CardGame.dungeon_main_screen.overlay_menu.proceed_button.set_label(TEXT[0]);
	load_treasure(room)

	if chest_type == TreasureRoom.ChestType.BOSS:
		particle = boss_effect_prefab.instantiate()
		add_child(particle)
		move_child(particle, 0)
		particle.global_position = chest_btn.global_position + chest_btn.size / 2
		particle.name = "BossChestEffect"
	else:
		particle = normal_effect_prefab.instantiate()
		add_child(particle)
		move_child(particle, 0)
		particle.global_position = chest_btn.global_position + chest_btn.size / 2
		particle.name = "NormalChestEffect"

		if shine_effect == null:
			shine_effect = CardGame.effect_library.chest_shine_effect_prefab.instantiate()
			add_child(shine_effect)
			shine_effect.global_position = chest_btn.global_position + chest_btn.size / 2
			shine_effect.stop(true)
			shine_effect.name = "ChestShineEffect"
	
	is_opened = false


func close():
	if not visible:
		return
	visible = false
	if shine_effect:
		shine_effect.queue_free()
		shine_effect = null

func load_treasure(room: TreasureRoom) -> void:
	if particle:
		particle.queue_free()
	chest_type = room.chest_type
	match chest_type:
		TreasureRoom.ChestType.SMALL:
			chest_img = ImageMaster.treasure_chest_small
			opened_chest_img = ImageMaster.treasure_chest_small_opened
			chest_btn.position = Vector2(-139, 74)
			chest_btn.size = Vector2(250, 150)
		TreasureRoom.ChestType.MEDIUM:
			chest_img = ImageMaster.treasure_chest_medium
			opened_chest_img = ImageMaster.treasure_chest_medium_opened
			chest_btn.position = Vector2(-126, -38)
			chest_btn.size = Vector2(250, 250)
		TreasureRoom.ChestType.LARGE:
			chest_img = ImageMaster.treasure_chest_large
			opened_chest_img = ImageMaster.treasure_chest_large_opened
			chest_btn.position = Vector2(-159, 29)
			chest_btn.size = Vector2(324, 202)
		TreasureRoom.ChestType.BOSS:
			chest_img = ImageMaster.treasure_chest_boss
			opened_chest_img = ImageMaster.treasure_chest_boss_opened
			chest_btn.position = Vector2(-162, 17)
			chest_btn.size = Vector2(324, 210)

	
func _on_chest_mouse_entered() -> void:
	if is_opened:
		return
	chest_sprite.modulate = Color.WHITE * 1.5
	pass

func _on_chest_mouse_exitd() -> void:
	if is_opened:
		return
	chest_sprite.modulate = Color.WHITE
	pass

func _set_is_opened(value: bool) -> void:
	is_opened = value
	if is_opened:
		chest_sprite.texture = opened_chest_img
		if particle:
			particle.stop()
		if shine_effect:
			shine_effect.stop()
	else:
		chest_sprite.texture = chest_img
		if particle:
			particle.play()
		if shine_effect:
			shine_effect.play()
		
	chest_sprite.modulate = Color.WHITE


func _on_chest_clicked() -> void:
	if is_opened:
		return
	is_opened = true
	CardGame.sound.single_play("CHEST_OPEN")
	# open reward
	if chest_type != TreasureRoom.ChestType.BOSS:
		CardGame.dungeon_main_screen.dungeon_room_screen.end_room()
		CardGame.dungeon_main_screen.combat_reward_screen.clear_rewards()
		CardGame.dungeon_main_screen.open_screen(DungeonMainScreen.ScreenType.COMBAT_REWARD)
	else:
		CardGame.dungeon_main_screen.boss_relic_reward_screen.clear_rewards()
		CardGame.dungeon_main_screen.open_screen(DungeonMainScreen.ScreenType.BOSS_REWARD)
