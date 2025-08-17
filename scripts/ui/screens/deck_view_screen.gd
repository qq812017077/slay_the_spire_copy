class_name DeckViewScreen
extends Control

enum DeckViewMode {MASTER_DECK_VIEW, UPGRADE_DECK_VIEW, PURGE_DECK_VIEW}

static var HOVERING_SCALE: Vector2 = Vector2(1.3, 1.3)
static var NORMAL_SCALE: Vector2 = Vector2(1, 1)
static var RECOVERING_SCALE: Vector2 = Vector2(0.8, 0.8)

static var ui_string: UIString = null
static var TEXT: Array = []
const move_speed: float = 10
static func initialize():
	ui_string = CardGame.languagePack.get_ui_string("MasterDeckViewScreen")
	TEXT = ui_string.TEXT


@export var black_bg: Control = null
@export var tab_bar: Control = null
@export var master_deck_sort_header: MasterDeckSortHeader = null
@export_group("Scroll")
@export var scroll_container: ScrollContainer = null
@export var v_slider: VerticalSlider = null
@export_group("")

@export_group("ViewPopup")
@export var single_card_popup: SingleCardViewPopup = null
@export var upgrade_card_popup: CardUpgradeViewPopup = null
@export var purge_card_popup: CardPurgeViewPopup = null
@export_group("")
@export var cards_container: CardContainer = null

var cur_deck_view_mode: DeckViewMode = DeckViewMode.MASTER_DECK_VIEW

var cur_scroll_max_value: float = 0
var slider_step: float = 0
var visible_cards: Array = []
var selected_cardwidget: CardWidget = null
func _ready() -> void:
	if scroll_container != null:
		scroll_container.mouse_filter = Control.MOUSE_FILTER_IGNORE
		scroll_container.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_SHOW_NEVER
		scroll_container.get_v_scroll_bar().allow_greater = true
		scroll_container.get_v_scroll_bar().allow_lesser = true

	black_bg.self_modulate = Color(0, 0, 0, 0)
	gui_input.connect(_on_screen_gui_input)
	master_deck_sort_header.sort.connect(_on_set_sort_type)
	

func _process(delta: float) -> void:
	var clamp_delta = clamp(delta, 0.001, 0.02)
	for card: CardWidget in visible_cards:
		if card.is_hovering():
			if (card.scale - HOVERING_SCALE).length_squared() > Global.EPLISON:
				# card.scale = card.scale.lerp(HOVERING_SCALE, delta * move_speed * 10)
				card.scale = MathHelper.vec2_lerp_snap(card.scale, HOVERING_SCALE, clamp_delta * move_speed * 10)
			else:
				card.scale = HOVERING_SCALE
			card.z_index = 1
		else:
			if (card.scale - NORMAL_SCALE).length_squared() > Global.EPLISON:
				# card.scale = card.scale.lerp(NORMAL_SCALE, delta * move_speed)
				card.scale = MathHelper.vec2_lerp_snap(card.scale, NORMAL_SCALE, clamp_delta * move_speed)
			else:
				card.scale = NORMAL_SCALE
			card.z_index = 0
	
	var target_scroll_vertical: int = roundi((100.0 - v_slider.value) * slider_step)
	scroll_container.scroll_vertical = roundi(target_scroll_vertical)


	if visible:
		black_bg.self_modulate.a = MathHelper.lerp_snap(black_bg.self_modulate.a, 0.8, delta * 10)
	else:
		black_bg.self_modulate.a = MathHelper.lerp_snap(black_bg.self_modulate.a, 0, delta * 10)
func open(cards: Array[AbstractCard], deck_view_mode: DeckViewMode) -> void:
	# CardGame.dungeon_main_screen.player.release_cards()
	cur_deck_view_mode = deck_view_mode
	if cur_deck_view_mode != DeckViewMode.MASTER_DECK_VIEW:
		tab_bar.hide()
		scroll_container.position.y = 200
	else:
		tab_bar.show()
		scroll_container.position.y = 100
	visible = true
	CardGame.sound.single_play("DECK_OPEN")
	load_card_pool(cards)
	master_deck_sort_header.reset()

	single_card_popup.close()
	upgrade_card_popup.close()
	purge_card_popup.close()

	if cards.size() > (cards_container.columns * 3):
		v_slider.show()
	else:
		v_slider.hide()
	await get_tree().process_frame
	
	cur_scroll_max_value = scroll_container.get_v_scroll_bar().max_value
	var page_size = scroll_container.size.y
	slider_step = (cur_scroll_max_value - page_size * 2 / 3) / (v_slider.max_value - v_slider.min_value)
	# print("cur_scroll_max_value:", cur_scroll_max_value)
	# print("page_size:", page_size)
	# print("slider_step:", slider_step)
	v_slider.set_slider_percent(1)

func close(instant: bool = false) -> void:
	visible = false
	CardGame.sound.single_play("DECK_CLOSE")
	if instant:
		black_bg.self_modulate.a = 0
func load_card_pool(cards: Array[AbstractCard]) -> void:
	clear_card_pool()
	for card: AbstractCard in cards:
		append_card(card)

func clear_card_pool() -> void:
	for card_widget in visible_cards:
		CardWidget.recycle(card_widget)
	visible_cards.clear()

func append_card(card: AbstractCard) -> void:
	var card_widget = CardWidget.allocate_by_type(card.type)
	card_widget.set_cardscale(Settings.scale * 0.9)
	card_widget.enable_card_tip = true
	card_widget.on_card_clicked = _on_cardwidget_clicked
	cards_container.add_child(card_widget)

	card_widget.load_card(card)
	visible_cards.append(card_widget)

func remove_card(card: AbstractCard) -> void:
	for card_widget in visible_cards:
		if card_widget.card == card:
			cards_container.remove_child(card_widget)
			CardWidget.recycle(card_widget)
			visible_cards.erase(card_widget)
			break

func _on_screen_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var input_event = event as InputEventMouseButton
		var step: float = scroll_container.size.y / cur_scroll_max_value * 0.1
		if input_event.button_index == MOUSE_BUTTON_WHEEL_UP:
			v_slider.target_slider_percent += step
			# v_slider.target_slider_percent = clamp(v_slider.target_slider_percent + step, 0, 1)
			# if v_slider.target_slider_percent >= 1:
			# 	scroll_container.scroll_vertical -= scroll_step
		if input_event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			v_slider.target_slider_percent -= step
			# v_slider.target_slider_percent = clamp(v_slider.target_slider_percent - step, 0, 1)
			# if v_slider.target_slider_percent <= 0:
			# 	scroll_container.scroll_vertical += scroll_step
		# print("v_slider.target_slider_percent:", v_slider.target_slider_percent)
func _on_set_sort_type(sort_type: SortHeader.SortType, ascending_order: bool) -> void:
	var target_comparator: Callable
	var ordered_master_cards: Array = visible_cards.duplicate()
	match sort_type:
		SortHeader.SortType.ObtaingOrder:
			if not ascending_order:
				ordered_master_cards.reverse()
		SortHeader.SortType.Type:
			target_comparator = CardHelper.type_sort_ascending if ascending_order else CardHelper.type_sort_descending
			ordered_master_cards = SortHelper.custom_stable_sort(visible_cards, target_comparator)
		SortHeader.SortType.Cost:
			target_comparator = CardHelper.cost_sort_ascending if ascending_order else CardHelper.cost_sort_descending
			ordered_master_cards = SortHelper.custom_stable_sort(ordered_master_cards, target_comparator)

	var i: int = 0
	for card in ordered_master_cards:
		cards_container.move_child(card, i)
		i += 1


func _on_cardwidget_clicked(cardwidget: CardWidget) -> void:
	selected_cardwidget = cardwidget
	if cur_deck_view_mode == DeckViewMode.MASTER_DECK_VIEW:
		single_card_popup.open(cardwidget, visible_cards, false)
	elif cur_deck_view_mode == DeckViewMode.UPGRADE_DECK_VIEW:
		upgrade_card_popup.open(cardwidget.card)
		CardGame.dungeon_main_screen.overlay_menu.reshow_cancel_button()
		CardGame.dungeon_main_screen.overlay_menu.confirm_button.show_button()
	elif cur_deck_view_mode == DeckViewMode.PURGE_DECK_VIEW:
		purge_card_popup.open(cardwidget.card)
		CardGame.dungeon_main_screen.overlay_menu.reshow_cancel_button()
		CardGame.dungeon_main_screen.overlay_menu.confirm_button.show_button()
	
func close_upgraded_popup() -> void:
	upgrade_card_popup.close()
	CardGame.dungeon_main_screen.overlay_menu.reshow_cancel_button()
	CardGame.dungeon_main_screen.overlay_menu.confirm_button.hide_button()

func close_purged_popup() -> void:
	purge_card_popup.close()
	CardGame.dungeon_main_screen.overlay_menu.reshow_cancel_button()
	CardGame.dungeon_main_screen.overlay_menu.confirm_button.hide_button()


func upgrade_select_card() -> void:
	upgrade_card_popup.close()
	var effect = UpgradeShineEffect.new(Vector2(Settings.DEFAULT_WIDTH / 2.0, Settings.DEFAULT_HEIGHT / 2.0))
	CardGame.dungeon_main_screen.add_game_effect(effect)
	selected_cardwidget.card.upgrade()
	var card_breifly_show_effect = ShowCardBrieflyEffect.new(selected_cardwidget.card)
	CardGame.dungeon_main_screen.add_game_effect(card_breifly_show_effect)


func purge_select_card() -> void:
	purge_card_popup.close()
	CardGame.dungeon_main_screen.player.master_decks.remove_card(selected_cardwidget.card)
	CardGame.dungeon_main_screen.add_game_effect(PurgeCardEffect.new(selected_cardwidget.card, Vector2(Settings.DEFAULT_WIDTH / 2.0, Settings.DEFAULT_HEIGHT / 2.0)))
	CardGame.dungeon_main_screen.top_panel.refresh_master_deck_amount()
