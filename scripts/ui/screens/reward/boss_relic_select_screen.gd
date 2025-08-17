class_name BossRelicSelectScreen
extends Control

const BANNER_Y: float = 280
static var ui_string: UIString = null
static var TEXT: Array = []
static func initialize() -> void:
	ui_string = CardGame.languagePack.get_ui_string("BossRelicSelectScreen")
	TEXT = ui_string.TEXT

@export var black_mask: Control = null
@export var relic_bg: Sprite2D = null
@export var cancel_button: ScreenButton = null

var relic_list: Array[AbstractRelic] = []
var fading_tween: Tween = null
var close_timer: Timer = null

var shine_effect: ChestShineEffect = null
func _ready() -> void:
	visible = false
	black_mask.modulate = Color(0, 0, 0, 0)
	relic_bg.modulate.a = 0.0
	cancel_button.button.pressed.connect(_on_cancel_button_pressed)
	
	close_timer = Timer.new()
	close_timer.name = "close_timer"
	add_child(close_timer)
	close_timer.timeout.connect(func() -> void: visible = false)
	close_timer.one_shot = true

func enable_input() -> void:
	black_mask.mouse_filter = Control.MOUSE_FILTER_STOP

func disable_input() -> void:
	black_mask.mouse_filter = Control.MOUSE_FILTER_IGNORE

func open():
	if not close_timer.is_stopped():
		close_timer.stop()
	
	visible = true
	enable_input()
	shine_effect = CardGame.effect_library.boss_chest_shine_effect_prefab.instantiate()
	shine_effect.play()
	CardGame.dungeon_main_screen.add_particle_effect(shine_effect)

	if fading_tween != null and fading_tween.is_running():
		fading_tween.stop()
	fading_tween = create_tween()
	fading_tween.parallel().tween_property(black_mask, "modulate", Color(0, 0, 0, 0.7), 0.3)
	# fading_tween.parallel().tween_property(relic_bg, "modulate", Color.WHITE, 0.1)
	relic_bg.modulate = Color.WHITE
	
	cancel_button.hide_button(true)
	cancel_button.show_button_with_name(TEXT[3])
	if CardGame.dungeon_main_screen:
		CardGame.dungeon_main_screen.dungeon_room_screen.move_player_and_treasure_to_front()
		CardGame.dungeon_main_screen.overlay_menu.show_black()
		CardGame.dungeon_main_screen.overlay_menu.dynamic_banner.show_banner_at(BANNER_Y, TEXT[2], false)
		CardGame.dungeon_main_screen.overlay_menu.proceed_button.hide_button()


func close(instant: bool = false):
	disable_input()
	
	CardGame.dungeon_main_screen.dungeon_room_screen.move_player_and_treasure_to_back()
	CardGame.dungeon_main_screen.overlay_menu.proceed_button.show_button()
	shine_effect.stop()
	if instant:
		black_mask.modulate = Color(0, 0, 0, 0)
		relic_bg.modulate.a = 0.0
		CardGame.dungeon_main_screen.overlay_menu.dynamic_banner.hide_banner(true)
		CardGame.dungeon_main_screen.overlay_menu.hide_black(true)
		visible = false
		return

	if fading_tween != null and fading_tween.is_running():
		fading_tween.stop()
	fading_tween = create_tween()
	fading_tween.parallel().tween_property(black_mask, "modulate", Color(0, 0, 0, 0.0), 0.2)
	fading_tween.parallel().tween_property(relic_bg, "modulate", Color(0, 0, 0, 0.0), 0.2)

	cancel_button.hide_button(instant)
	CardGame.dungeon_main_screen.overlay_menu.dynamic_banner.hide_banner()
	CardGame.dungeon_main_screen.overlay_menu.hide_black()

	if not close_timer.is_stopped():
		close_timer.stop()
	close_timer.start(max(DynamicBanner.ANIM_TIME, 0.5))

func clear_rewards() -> void:
	# for reward: RewardItemWidget in rewards:
	# 	reward.queue_free()
	# rewards.clear()
	pass


func _on_cancel_button_pressed() -> void:
	CardGame.dungeon_main_screen.close_current_screen()
	CardGame.dungeon_main_screen.dungeon_room_screen.treasure_ui.is_opened = false
