class_name CardSelectRewardScreen
extends Control

static var CARD_SCALE: float = 0.9
static var HOVERING_SCALE: Vector2 = Vector2(1.3, 1.3)
static var NORMAL_SCALE: Vector2 = Vector2(1, 1)
const PAD_X: float = 40.0
const TARGET_Y: float = Settings.DEFAULT_HEIGHT * 0.37
static var ui_string: UIString = null
static var TEXT: Array = []
static func initialize() -> void:
	ui_string = CardGame.languagePack.get_ui_string("CardRewardScreen")
	TEXT = ui_string.TEXT


@export var btn_container: HBoxContainer = null
@export var skip_btn: TakeButton = null
@export var singing_bowl_btn: TakeButton = null
var dynamic_banner: DynamicBanner = null
var skippable: bool = false

var cur_reward_widget: RewardItemWidget = null
var card_reward_group: Array[CardWidget] = []
var banner_header: String = ""
var wait_timer: float = 0.0
func _ready() -> void:
	skip_btn.set_label(TEXT[0])
	singing_bowl_btn.set_label(TEXT[2])
	if dynamic_banner == null:
		dynamic_banner = DynamicBanner.new()
		add_child(dynamic_banner)
	
	skip_btn.btn.pressed.connect(on_skip_button_pressed)

func _process(delta: float) -> void:
	if wait_timer >= 0.0:
		wait_timer -= delta
		return 
	var clamp_delta = clamp(delta, 0.001, 0.02)
	for card in card_reward_group:
		card.position.x = MathHelper.lerp_snap(card.position.x, card.target_pos.x, clamp_delta * 12.0)
		card.position.y = MathHelper.lerp_snap(card.position.y, card.target_pos.y, clamp_delta * 12.0)

		if card.is_hovering():
			card.scale = MathHelper.vec2_lerp_snap(card.scale, HOVERING_SCALE, clamp_delta * 10)
		else:
			card.scale = MathHelper.vec2_lerp_snap(card.scale, NORMAL_SCALE, clamp_delta * 10)

func open(reward_widget: RewardItemWidget, header: String) -> void:
	visible = true
	cur_reward_widget = reward_widget
	skippable = true
	banner_header = header
	skip_btn.show_button()
	singing_bowl_btn.hide_button()
	var children: Array = btn_container.get_children()
	for i in range(skip_btn.get_index() + 1, singing_bowl_btn.get_index()):
		children[i].hide()
	
	
	for card in card_reward_group:
		CardWidget.recycle(card)
	card_reward_group.clear()
	for card in cur_reward_widget.reward_item.cards:
		var card_widget = CardWidget.allocate(card, self, CARD_SCALE)
		card_widget.refresh_card_state_in_process = true
		card_reward_group.append(card_widget)
		card_widget.on_card_clicked = _on_cardwidget_clicked
		card_widget.on_card_just_hovered = _on_cardwidget_just_hovered
	dynamic_banner.show_banner(header)
	place_cards(Vector2(Settings.DEFAULT_WIDTH * 0.5 - AbstractCard.IMG_WIDTH * 0.5 * CARD_SCALE, TARGET_Y))


	for card in card_reward_group:
		card.disable()
	
	var enable_timer = get_tree().create_timer(0.05)
	enable_timer.timeout.connect(func() -> void:
		for card in card_reward_group:
			card.enable())

	wait_timer = 0.03
func reopen() -> void:
	visible = true
	skip_btn.show_button()
	singing_bowl_btn.hide_button()
	var children: Array = btn_container.get_children()
	for i in range(skip_btn.get_index() + 1, singing_bowl_btn.get_index()):
		children[i].hide()
	
	dynamic_banner.show_banner(banner_header)

func close() -> void:
	visible = false
	skip_btn.hide_button()
	singing_bowl_btn.hide_button()
	dynamic_banner.hide_banner(true)

func place_cards(pos: Vector2) -> void:
	var count: int = card_reward_group.size()
	for card in card_reward_group:
		card.set_position(pos)
		var idx: int = card_reward_group.find(card)
		card.target_pos.x = pos.x + (idx - (count - 1) / 2.0) * (AbstractCard.IMG_WIDTH + PAD_X)
		card.target_pos.y = TARGET_Y


func _on_cardwidget_clicked(cardwidget: CardWidget) -> void:
	CardGame.dungeon_main_screen.close_current_screen()
	CardGame.dungeon_main_screen.combat_reward_screen.take_reward(cur_reward_widget)
	
	CardGame.sound.single_play("CARD_SELECT")
	var obtain_timer = get_tree().create_timer(0.1)
	obtain_timer.timeout.connect(func() -> void:
		cardwidget.scale = NORMAL_SCALE
		card_reward_group.erase(cardwidget)
		CardGame.soul.obtain_card(cardwidget)
		)
	

func _on_cardwidget_just_hovered(_cardwidget: CardWidget) -> void:
	# push_error("card just hovered: ", _cardwidget.name)
	CardGame.sound.single_play("CARD_OBTAIN", 0.4)

func on_skip_button_pressed() -> void:
	CardGame.dungeon_main_screen.close_current_screen()
