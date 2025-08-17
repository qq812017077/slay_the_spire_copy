class_name CombatRewardScreen
extends Control

const TRANSPARENT_COLOR = Color(0, 0, 0, 0.0)
const REWARD_ANIM_TIME = 0.2
static var ui_string: UIString = null
static var TEXT: Array = []
static func initialize() -> void:
	ui_string = CardGame.languagePack.get_ui_string("CombatRewardScreen")
	TEXT = ui_string.TEXT

@export var black_mask: Control = null
@export var sheet: Control = null
@export var dynamic_banner: DynamicBanner = null
@export var rewards_container: VBoxContainer = null
@export var reward_widget_prefab: PackedScene = null
var rewards: Array[RewardItemWidget] = []
var label_override: String = ""

var mug: bool = false
var smoke: bool = false
var is_show: bool = false
var fading_tween: Tween = null
var close_timer: Timer = null
func _ready() -> void:
	sheet.modulate.a = 0.
	black_mask.modulate = Color(0, 0, 0, 0)
	if dynamic_banner == null:
		dynamic_banner = DynamicBanner.new()
		add_child(dynamic_banner)

	close_timer = Timer.new()
	close_timer.name = "close_timer"
	add_child(close_timer)
	close_timer.timeout.connect(func() -> void: visible = false)
	close_timer.one_shot = true

func has_taken_all() -> bool:
	return rewards.size() == 0

func enable_input() -> void:
	black_mask.mouse_filter = Control.MOUSE_FILTER_STOP

func disable_input() -> void:
	black_mask.mouse_filter = Control.MOUSE_FILTER_IGNORE

func open():
	if not close_timer.is_stopped():
		close_timer.stop()
	is_show = true
	visible = true
	mug = false
	smoke = false
	enable_input()
	if fading_tween != null and fading_tween.is_running():
		fading_tween.stop()
	fading_tween = create_tween()
	fading_tween.parallel().tween_property(black_mask, "modulate", Color(0, 0, 0, 0.7), 1)
	fading_tween.parallel().tween_property(sheet, "modulate", Color.WHITE, 0.5)

	if CardGame.dungeon_main_screen:
		dynamic_banner.show_banner(get_random_banner_label())
		label_override = ""
		set_proceed_button_label()
		CardGame.dungeon_main_screen.overlay_menu.proceed_button.show_button()
		CardGame.dungeon_main_screen.overlay_menu.show_black()

func reopen():
	# push_error("reopen")
	if not close_timer.is_stopped():
		close_timer.stop()
	is_show = true
	visible = true
	if fading_tween != null and fading_tween.is_running():
		fading_tween.stop()
	
	enable_input()
	fading_tween = create_tween()
	fading_tween.parallel().tween_property(black_mask, "modulate", Color(0, 0, 0, 0.7), 0.5)
	fading_tween.parallel().tween_property(sheet, "modulate", Color.WHITE, 0.5)
	# black_mask.modulate = Color(0, 0, 0, 0.7)
	# sheet.modulate = Color.WHITE
	dynamic_banner.show_banner(get_random_banner_label())
	CardGame.dungeon_main_screen.overlay_menu.proceed_button.show_button()
	CardGame.dungeon_main_screen.overlay_menu.show_black(true)
	
func close(instant: bool = false):
	is_show = false

	if fading_tween != null and fading_tween.is_running():
		fading_tween.stop()

	disable_input()
	if instant:
		black_mask.modulate = TRANSPARENT_COLOR
		sheet.modulate = TRANSPARENT_COLOR
		dynamic_banner.hide_banner(true)
		CardGame.dungeon_main_screen.overlay_menu.proceed_button.hide_button(true)
		CardGame.dungeon_main_screen.overlay_menu.hide_black(true)
		visible = false
		return
	
	fading_tween = create_tween()
	fading_tween.parallel().tween_property(black_mask, "modulate", TRANSPARENT_COLOR, 0.5)
	fading_tween.parallel().tween_property(sheet, "modulate", TRANSPARENT_COLOR, 0.3)

	dynamic_banner.hide_banner()
	CardGame.dungeon_main_screen.overlay_menu.proceed_button.hide_button()
	CardGame.dungeon_main_screen.overlay_menu.hide_black()

	if not close_timer.is_stopped():
		close_timer.stop()
	close_timer.start(max(DynamicBanner.ANIM_TIME, 1))


func get_random_banner_label() -> String:
	var list: Array = []
	if CardGame.dungeon_main_screen.dungeon.cur_room_node.room.type == AbstractRoom.RoomType.TREASURE:
		list = [TEXT[7], TEXT[8]]
	else:
		list = [TEXT[9], TEXT[10], TEXT[11]]
	
	return list[CardGame.cur_dungeon.miscRng.randi_range(0, list.size() - 1)]

func set_proceed_button_label() -> void:
	var overlay_menu: OverlayMenu = CardGame.dungeon_main_screen.overlay_menu
	if rewards.size() == 0:
		overlay_menu.proceed_button.set_label(TEXT[0])
	elif rewards.size() == 1:
		match rewards[0].reward_item.type:
			RewardItem.RewardType.CARD:
				overlay_menu.proceed_button.set_label(TEXT[1])
			RewardItem.RewardType.GOLD:
				overlay_menu.proceed_button.set_label(TEXT[2])
			RewardItem.RewardType.RELIC:
				overlay_menu.proceed_button.set_label(TEXT[3])
			RewardItem.RewardType.POTION:
				overlay_menu.proceed_button.set_label(TEXT[4])
	else:
		overlay_menu.proceed_button.set_label(TEXT[5])

func flash() -> void:
	for reward: RewardItemWidget in rewards:
		reward.flash()

func clear_rewards() -> void:
	for reward: RewardItemWidget in rewards:
		reward.queue_free()
	rewards.clear()

func add_gold_reward(amount: int) -> void:
	var reward_item: RewardItem = RewardItem.new()
	reward_item.type = RewardItem.RewardType.GOLD
	reward_item.gold_amount = amount
	add_reward_widget(reward_item)

func add_card_reward(cards: Array[AbstractCard]) -> void:
	var reward_item: RewardItem = RewardItem.new()
	reward_item.type = RewardItem.RewardType.CARD
	reward_item.cards = cards
	add_reward_widget(reward_item)

func add_reward_widget(reward_item: RewardItem) -> void:
	var reward_widget: RewardItemWidget = reward_widget_prefab.instantiate()
	rewards_container.add_child(reward_widget)
	reward_widget.load_reward_item(reward_item)
	
	reward_widget.btn.mouse_entered.connect(_on_reward_item_mouse_entered)
	reward_widget.btn.pressed.connect(_on_reward_item_mouse_click.bind(reward_widget))
	rewards.append(reward_widget)

func _on_reward_item_mouse_entered() -> void:
	CardGame.sound.single_play("UI_HOVER")

func take_reward(reward_widget: RewardItemWidget) -> void:
	if not rewards.has(reward_widget):
		return
	rewards.erase(reward_widget)
	reward_widget.queue_free()
	set_proceed_button_label()
	if has_taken_all():
		CardGame.dungeon_main_screen.overlay_menu.proceed_button.show()

func _on_reward_item_mouse_click(reward_widget: RewardItemWidget) -> void:
	CardGame.sound.single_play("UI_CLICK_1")
	match reward_widget.reward_item.type:
		RewardItem.RewardType.CARD:
			CardGame.dungeon_main_screen.open_card_reward_screen(reward_widget, RewardItemWidget.TEXT[4])
		RewardItem.RewardType.GOLD:
			CardGame.sound.single_play("GOLD_GAIN")
			CardGame.dungeon_main_screen.player.gain_gold(reward_widget.reward_item.get_gold())
			take_reward(reward_widget)
		RewardItem.RewardType.RELIC:
			pass
		RewardItem.RewardType.POTION:
			pass
		RewardItem.RewardType.STOLEN_GOLD:
			pass
		RewardItem.RewardType.EMERALD_KEY:
			pass
		RewardItem.RewardType.SAPPHIRE_KEY:
			pass
