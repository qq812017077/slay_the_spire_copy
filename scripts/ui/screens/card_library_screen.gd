class_name CardLibraryScreen
extends Control

enum TabType {RED = 1, GREEN, BLUE, COLORLESS, CURSE, PURPLE = 8}

static var HOVERING_SCALE: Vector2 = Vector2(1.3, 1.3)
static var NORMAL_SCALE: Vector2 = Vector2(1, 1)
static var RECOVERING_SCALE: Vector2 = Vector2(0.8, 0.8)

static var ui_string: UIString = null
static var TEXT: Array = []
static var tab_types: Array = [TabType.RED, TabType.GREEN, TabType.BLUE, TabType.PURPLE, TabType.COLORLESS, TabType.CURSE]

@export var move_speed: float = 10
@export var cancel_button: ScreenButton = null

@export_group("ViewPopup")
@export var single_card_popup: SingleCardViewPopup = null
@export_group("")
@export_group("Prefabs")
@export var attack_prefab: PackedScene = null
@export var skill_prefab: PackedScene = null
@export var power_prefab: PackedScene = null

@export_group("Scroll")
@export var scroll_container: ScrollContainer = null
@export var v_slider: VSlider = null
@export_group("")

@export_group("Tab")
@export_range(0, 5) var current_index: int = 0:
	get = get_tab_index

enum TabIndex {RED, GREEN, BLUE, PURPLE, COLORLESS, CURSE}
@export var tabs: Array[TextureButton] = []

@export var card_lib_sort_header: CardLibSortHeader = null
@export var upgrade_toggle_button: TopPanelToggleButton = null
@export_group("")

@export var cards_container: Node = null


var initialized: bool = false

var red_visible_cardwidgets: Array = []
var green_visible_cardwidgets: Array = []
var blue_visible_cardwidgets: Array = []
var purple_visible_cardwidgets: Array = []
var colorless_visible_cardwidgets: Array = []
var curse_visible_cardwidgets: Array = []
var visible_cards: Array = []

var cancel_click_event: Callable
var cur_scroll_max_value: float = 0
var slider_step: float = 0
var grabber_height: float = 0
var target_slider_percent: float = 1

func _ready() -> void:
	initialized = false
	if ui_string == null:
		ui_string = CardGame.languagePack.get_ui_string("CardLibraryScreen")
		TEXT = ui_string.TEXT
	
	single_card_popup.card_library_screen = self
	cancel_button.button.text = TEXT[0]
	cancel_button.button.pressed.connect(_cancel_clicked)

	if scroll_container != null:
		scroll_container.mouse_filter = Control.MOUSE_FILTER_IGNORE
		scroll_container.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_SHOW_NEVER
		scroll_container.get_v_scroll_bar().allow_greater = true

	# v_slider
	v_slider.gui_input.connect(_on_slider_gui_input)
	var grabber = v_slider.get_theme_icon("grabber", "VSlider")
	if grabber != null:
		grabber_height = grabber.get_height()

	gui_input.connect(_on_screen_gui_input)
	upgrade_toggle_button.toggled.connect(_on_upgrade_toggle_button_clicked)
	card_lib_sort_header.sort.connect(_on_set_sort_type)
	initialize_tabs()
	
	initialize_cards()

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
	
	var target_value = (v_slider.max_value - v_slider.min_value) * target_slider_percent
	v_slider.value = MathHelper.lerp_snap(v_slider.value, target_value, delta * 12)
	scroll_container.scroll_vertical = int((100.0 - v_slider.value) * slider_step)

func open(cancel_event: Callable = Callable()) -> void:
	self.show()
	cancel_button.show_button()
	cancel_click_event = cancel_event
	current_index = 0
	single_card_popup.close()
	set_tab_index(current_index, true)

func close() -> void:
	hide()
	cancel_button.hide_button(true)


func clean() -> void:
	var nodes = cards_container.get_children()

	for node in nodes:
		cards_container.remove_child(node)
		node.queue_free()

func set_cards_visible(card_list: Array, seen: bool) -> void:
	for card in card_list:
		card.visible = seen

func set_cards_upgrade(card_list: Array, upgrade: bool) -> void:
	for card_widget: CardWidget in card_list:
		card_widget.display_in_library(upgrade)

func set_all_visible(seen: bool) -> void:
	set_cards_visible(red_visible_cardwidgets, seen)
	set_cards_visible(green_visible_cardwidgets, seen)
	set_cards_visible(blue_visible_cardwidgets, seen)
	set_cards_visible(purple_visible_cardwidgets, seen)
	set_cards_visible(colorless_visible_cardwidgets, seen)
	set_cards_visible(curse_visible_cardwidgets, seen)

func generate_visible_cardwidgets(_cards: Array) -> Array:
	var output: Array = []
	for card in _cards:
		var card_widget = CardWidget.allocate_by_type(card.type)
		card_widget.set_cardscale(Settings.scale * 0.9)
		card_widget.enable_card_tip = true
		card_widget.on_card_clicked = _on_cardwidget_clicked
		cards_container.add_child(card_widget)
		output.append(card_widget)
	return output

func init_cardwidgets(card_widgets: Array, cards: Array) -> void:
	for idx in range(card_widgets.size()):
		card_widgets[idx].load_card(cards[idx])

func set_container_bind(card_widgets: Array) -> void:
	for widget: Node in card_widgets:
		widget.scale = NORMAL_SCALE
		cards_container.add_child(widget)

func initialize_cards() -> void:
	var red_cards = CardLibrary.get_card_list(CardLibrary.LibraryType.RED)
	var green_cards = CardLibrary.get_card_list(CardLibrary.LibraryType.GREEN)
	var blue_cards = CardLibrary.get_card_list(CardLibrary.LibraryType.BLUE)
	var purple_cards = CardLibrary.get_card_list(CardLibrary.LibraryType.PURPLE)
	var colorless_cards = CardLibrary.get_card_list(CardLibrary.LibraryType.COLORLESS)
	var curse_cards = CardLibrary.get_card_list(CardLibrary.LibraryType.CURSE)
	
	red_visible_cardwidgets = generate_visible_cardwidgets(red_cards)
	green_visible_cardwidgets = generate_visible_cardwidgets(green_cards)
	blue_visible_cardwidgets = generate_visible_cardwidgets(blue_cards)
	purple_visible_cardwidgets = generate_visible_cardwidgets(purple_cards)
	colorless_visible_cardwidgets = generate_visible_cardwidgets(colorless_cards)
	curse_visible_cardwidgets = generate_visible_cardwidgets(curse_cards)
	
	await get_tree().process_frame

	init_cardwidgets(red_visible_cardwidgets, red_cards)
	init_cardwidgets(green_visible_cardwidgets, green_cards)
	init_cardwidgets(blue_visible_cardwidgets, blue_cards)
	init_cardwidgets(purple_visible_cardwidgets, purple_cards)
	init_cardwidgets(colorless_visible_cardwidgets, colorless_cards)
	init_cardwidgets(curse_visible_cardwidgets, curse_cards)
	

	var init_visible = visible
	self.modulate.a = 0
	set_all_visible(true)
	await get_tree().process_frame
	show()
	await get_tree().process_frame
	if not init_visible:
		hide()
	await get_tree().process_frame
	self.modulate.a = 1

	set_tab_index(current_index, true)
	initialized = true

	
func initialize_tabs() -> void:
	var tab_indices: Array = [TabIndex.RED, TabIndex.GREEN, TabIndex.BLUE, TabIndex.PURPLE, TabIndex.COLORLESS, TabIndex.CURSE]
	
	for i in range(tabs.size()):
		var tab_index = tab_indices[i]
		var tab_type = tab_types[i]
		var tab_label: Label = tabs[tab_index].get_child(0) as Label
		tab_label.text = TEXT[tab_type]
		tab_label.add_theme_font_override("font", ThemeHelper.get_regular_font())
		tab_label.add_theme_color_override("font_outline_color", get_tab_label_outline_color(tab_type))
		tab_label.add_theme_font_size_override("font_size", ThemeHelper.tab_font_size)
		tab_label.add_theme_constant_override("outline_size", int(ThemeHelper.tab_font_size * 0.5))
		# tabs[tab_index].connect("toggled", _on_tab_clicked)
		tabs[tab_index].pressed.connect(_on_tab_clicked)
		tabs[tab_index].mouse_entered.connect(_on_tab_mouse_entered)
	
	ThemeHelper.apply_top_panel_font_style(upgrade_toggle_button)

func render_tabs() -> void:
	for i in range(tabs.size()):
		var tab_label: Label = tabs[i].get_child(0) as Label
		if i == current_index:
			# current tab is selected.
			tabs[i].z_index = 1
			tab_label.add_theme_color_override("font_color", ThemeHelper.tab_font_selected_color)
		else:
			tabs[i].z_index = -i - 1
			tab_label.add_theme_color_override("font_color", ThemeHelper.tab_font_normal_color)
	
	card_lib_sort_header.self_modulate = get_tabbar_color(tab_types[current_index])

func get_tab_label_outline_color(tab_type: TabType) -> Color:
	match tab_type:
		TabType.RED:
			return Color(0.5, 0.1, 0.1, 1.0) * 0.5
		TabType.GREEN:
			return Color(0.25, 0.55, 0.0, 1.0) * 0.5
		TabType.BLUE:
			return Color(0.01, 0.34, 0.52, 1.0) * 0.5
		TabType.PURPLE:
			return Color(0.37, 0.27, 0.49, 1.0) * 0.5
		TabType.COLORLESS:
			return Color(0.4, 0.4, 0.4, 1.0) * 0.5
		TabType.CURSE:
			return Color(0.18, 0.18, 0.16, 1.0) * 0.5
	return Color.WHITE * 0.5

func get_tabbar_color(tab_type: TabType) -> Color:
	match tab_type:
		TabType.RED:
			return Color(0.5, 0.1, 0.1, 1.0)
		TabType.GREEN:
			return Color(0.25, 0.55, 0.0, 1.0)
		TabType.BLUE:
			return Color(0.01, 0.34, 0.52, 1.0)
		TabType.PURPLE:
			return Color(0.37, 0.27, 0.49, 1.0)
		TabType.COLORLESS:
			return Color(0.4, 0.4, 0.4, 1.0)
		TabType.CURSE:
			return Color(0.18, 0.18, 0.16, 1.0)
	return Color.WHITE


func get_tab_index() -> int:
	return current_index

func set_tab_index(idx: int, force: bool = false) -> void:
	if !force and current_index == idx:
		return
	
	current_index = idx
	render_tabs()
	set_all_visible(false)
	match tab_types[current_index]:
		TabType.RED:
			visible_cards = red_visible_cardwidgets
		TabType.GREEN:
			visible_cards = green_visible_cardwidgets
		TabType.BLUE:
			visible_cards = blue_visible_cardwidgets
		TabType.PURPLE:
			visible_cards = purple_visible_cardwidgets
		TabType.COLORLESS:
			visible_cards = colorless_visible_cardwidgets
		TabType.CURSE:
			visible_cards = curse_visible_cardwidgets
	set_cards_visible(visible_cards, true)
	if initialized:
		card_lib_sort_header.reset()

	await get_tree().process_frame
	await get_tree().process_frame

	for card: CardWidget in visible_cards:
		card.scale = RECOVERING_SCALE
	cur_scroll_max_value = scroll_container.get_v_scroll_bar().max_value
	var page_size = scroll_container.size.y
	slider_step = (cur_scroll_max_value - page_size * 2 / 3) / (v_slider.max_value - v_slider.min_value)

	target_slider_percent = 1
	v_slider.value = 100
	# v_slider.value = (v_slider.max_value - v_slider.min_value) * target_slider_percent

	# print("cur_max_value:", cur_max_value)
func _on_tab_clicked() -> void:
	var idx: int = 0
	for tab in tabs:
		if tab.button_pressed:
			set_tab_index(idx)
			break
		idx += 1

func _on_tab_mouse_entered() -> void:
	CardGame.sound.single_play("UI_HOVER", -0.4)
	
func _cancel_clicked() -> void:
	if cancel_click_event.is_valid():
		cancel_click_event.call()
		close()

# func _on_slider_changed(value: float) -> void:
# 	# print("changed value:", value)
# 	scroll_container.scroll_vertical = int((100.0 - value) * slider_step)

func _on_screen_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var input_event = event as InputEventMouseButton
		var step: float = scroll_container.size.y / cur_scroll_max_value * 0.1
		if input_event.button_index == MOUSE_BUTTON_WHEEL_UP:
			target_slider_percent = clamp(target_slider_percent + step, 0, 1)
		if input_event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			target_slider_percent = clamp(target_slider_percent - step, 0, 1)
	
func _on_slider_gui_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		var input_event = event as InputEventMouse
		if input_event.button_mask == MOUSE_BUTTON_LEFT:
			# print("position:", input_event.position)
			var percent = clamp((input_event.position.y - grabber_height * 0.5) / (v_slider.size.y - grabber_height), 0.0, 1.0)
			target_slider_percent = 1 - percent

func _on_upgrade_toggle_button_clicked(_toggle_on: bool) -> void:
	CardGame.sound.single_play("UI_CLICK_1", -0.2)
	set_cards_upgrade(red_visible_cardwidgets, _toggle_on)
	set_cards_upgrade(green_visible_cardwidgets, _toggle_on)
	set_cards_upgrade(blue_visible_cardwidgets, _toggle_on)
	set_cards_upgrade(purple_visible_cardwidgets, _toggle_on)
	set_cards_upgrade(colorless_visible_cardwidgets, _toggle_on)
	set_cards_upgrade(curse_visible_cardwidgets, _toggle_on)

func rarity_sort_ascending(a: CardWidget, b: CardWidget):
	return a.card.rarity < b.card.rarity

func rarity_sort_descending(a: CardWidget, b: CardWidget):
	return a.card.rarity > b.card.rarity

func type_sort_ascending(a: CardWidget, b: CardWidget):
	return a.card.type < b.card.type

func type_sort_descending(a: CardWidget, b: CardWidget):
	return a.card.type > b.card.type

func cost_sort_ascending(a: CardWidget, b: CardWidget):
	return a.card.cost < b.card.cost

func cost_sort_descending(a: CardWidget, b: CardWidget):
	return a.card.cost > b.card.cost

func _on_set_sort_type(sort_type: CardLibSortHeader.SortType, ascending_order: bool) -> void:
	var target_comparator: Callable = rarity_sort_ascending
	match sort_type:
		CardLibSortHeader.SortType.Rarity:
			target_comparator = rarity_sort_ascending if ascending_order else rarity_sort_descending
			# visible_cards.sort_custom(rarity_sort_descending if descending_order else rarity_sort_ascending)
		CardLibSortHeader.SortType.Type:
			target_comparator = type_sort_ascending if ascending_order else type_sort_descending
			# visible_cards.sort_custom(type_sort_descending if descending_order else type_sort_ascending)
		CardLibSortHeader.SortType.Cost:
			target_comparator = cost_sort_ascending if ascending_order else cost_sort_descending
			# visible_cards.sort_custom(cost_sort_descending if descending_order else cost_sort_ascending)
	visible_cards = SortHelper.custom_stable_sort(visible_cards, target_comparator)
	# visible_cards.sort_custom(target_comparator)
	var i: int = 0
	for card in visible_cards:
		cards_container.move_child(card, i)
		i += 1

func _on_cardwidget_clicked(cardwidget: CardWidget) -> void:
	if not initialized:
		return 
	single_card_popup.open(cardwidget, visible_cards, upgrade_toggle_button.button_pressed)