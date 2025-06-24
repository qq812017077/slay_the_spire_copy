class_name CardLibraryScreen
extends Node

enum TabType { RED=1, GREEN, BLUE, COLORLESS, CURSE, PURPLE=8}

static var ui_string : UIString = null
static var texts: Array = []
static var tab_types: Array = [TabType.RED, TabType.GREEN, TabType.BLUE, TabType.PURPLE, TabType.COLORLESS, TabType.CURSE]

@export var move_speed: float = 10
@export_group("Prefabs")
@export var attack_prefab: PackedScene = null
@export var skill_prefab: PackedScene = null
@export var power_prefab: PackedScene = null

@export_group("Scroll")
@export var scroll_container: ScrollContainer = null
@export var v_scroll_bar: VScrollBar = null
@export_group("")

@export_group("Tab")
@export_range(0,5) var current_index : int = 0:
	get = get_tab_index

enum TabIndex { RED, GREEN, BLUE, PURPLE, COLORLESS, CURSE}
@export var tabs : Array[TextureButton] = []

@export var card_lib_sort_header: CardLibSortHeader = null
@export var upgrade_checkbox : CheckBox = null 
@export_group("")

@export var cards_container: Node = null

var red_cards: Array = []
var green_cards: Array = []
var blue_cards: Array = []
var purple_cards: Array = []
var colorless_cards: Array = []
var curse_cards: Array = []

var cards: Array = []

var visible_cards: Array = []

static var HOVERING_SCALE: Vector2 = Vector2(1.2, 1.2)
static var RECOVERING_SCALE: Vector2 = Vector2(0.6, 0.6)


func _ready() -> void:
	
	if ui_string == null:
		ui_string = CardGame.languagePack.get_ui_string("CardLibraryScreen")
		texts = ui_string.TEXT

	if scroll_container != null:
		scroll_container.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_SHOW_NEVER
		scroll_container.get_v_scroll_bar().share(v_scroll_bar)

	red_cards = CardLibrary.get_card_list(CardLibrary.LibraryType.RED)
	green_cards = CardLibrary.get_card_list(CardLibrary.LibraryType.GREEN)
	blue_cards = CardLibrary.get_card_list(CardLibrary.LibraryType.BLUE)
	purple_cards = CardLibrary.get_card_list(CardLibrary.LibraryType.PURPLE)
	colorless_cards = CardLibrary.get_card_list(CardLibrary.LibraryType.COLORLESS)
	curse_cards = CardLibrary.get_card_list(CardLibrary.LibraryType.CURSE)
	
	initialize_tabs()
	ThemeHelper.apply_top_panel_font_style(upgrade_checkbox)

	render_tabs()
	set_tab_index(current_index, true)

func _process(delta: float) -> void:
	for card : CardWidget in visible_cards:
		if card.is_hovering():
			if (card.scale - HOVERING_SCALE).length_squared() > 0.0001:
				card.scale = card.scale.lerp(HOVERING_SCALE, delta * move_speed * 5)
			else:
				card.scale = HOVERING_SCALE
			card.z_index = 1
		else:
			if (card.scale - Vector2.ONE).length_squared() > 0.0001:
				card.scale = card.scale.lerp(Vector2.ONE, delta * move_speed)
			else:
				card.scale = Vector2.ONE
			card.z_index = 0
			

func clean() -> void:
	var nodes = cards_container.get_children()

	for node in nodes:
		cards_container.remove_child(node)
		node.queue_free()
	

func generate_visible_cards(_cards: Array) -> Array:
	var nodes = cards_container.get_children()

	for node in nodes:
		cards_container.remove_child(node)
		CardWidget.recycle(node)

	var output: Array = []
	for card in _cards:
		var card_widget = CardWidget.allocate_by_type(card.type)
		cards_container.add_child(card_widget)
		card_widget.load_card(card)
		output.append(card_widget)

	return output


func initialize_tabs() -> void:
	var tab_indices: Array = [TabIndex.RED, TabIndex.GREEN, TabIndex.BLUE, TabIndex.PURPLE, TabIndex.COLORLESS, TabIndex.CURSE]
	
	for i in range(tabs.size()):
		var tab_index = tab_indices[i]
		var tab_type = tab_types[i]
		var tab_label: Label = tabs[tab_index].get_child(0) as Label
		tab_label.text = texts[tab_type]
		tab_label.add_theme_font_override("font", ThemeHelper.get_tab_label_font())
		tab_label.add_theme_color_override("font_outline_color",get_tab_label_outline_color(tab_type))
		tab_label.add_theme_font_size_override("font_size", ThemeHelper.tab_font_size)
		tab_label.add_theme_constant_override("outline_size", int(ThemeHelper.tab_font_size *0.5))
		# tabs[tab_index].connect("toggled", _on_tab_clicked)
		tabs[tab_index].connect("pressed", _on_tab_clicked)


func render_tabs() -> void:
	for i in range(tabs.size()):
		var tab_label: Label = tabs[i].get_child(0) as Label
		if i == current_index:
			# current tab is selected.
			tabs[i].z_index = 1
			tab_label.add_theme_color_override("font_color", ThemeHelper.tab_font_selected_color)
		else:
			tabs[i].z_index = -i
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
	return Color.WHITE  * 0.5

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

func set_tab_index(idx : int, force:bool=false) -> void:
	if !force and current_index == idx:
		return 
	current_index = idx
	render_tabs()
	match tab_types[current_index]:
		TabType.RED:
			visible_cards = generate_visible_cards(red_cards)
		TabType.GREEN:
			visible_cards = generate_visible_cards(green_cards)
		TabType.BLUE:
			visible_cards = generate_visible_cards(blue_cards)
		TabType.PURPLE:
			visible_cards = generate_visible_cards(purple_cards)
		TabType.COLORLESS:
			visible_cards = generate_visible_cards(colorless_cards)
		TabType.CURSE:
			visible_cards = generate_visible_cards(curse_cards)

	# visible_cards = [visible_cards[0]]
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame

	for card : CardWidget in visible_cards:
		card.scale = Vector2(0.6, 0.6)

	

func _on_tab_clicked() -> void:
	var idx : int = 0
	for tab in tabs:
		if tab.button_pressed:
			set_tab_index(idx)
			break
		idx += 1
	
	
