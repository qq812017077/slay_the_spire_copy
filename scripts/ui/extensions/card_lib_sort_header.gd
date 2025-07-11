class_name CardLibSortHeader
extends Control

signal sort(sort_type: SortType, descending_order: bool)

static var ui_string: UIString = null
static var header_texts: Array = []

enum SortType {Rarity = 0, Type = 1, Cost = 3}
@export var arrow_up: Texture2D = null
@export var arrow_down: Texture2D = null
@export var rarity_button: Button = null
@export var type_button: Button = null
@export var cost_button: Button = null

var buttons: Array[Button] = []
var current_sort_type: SortType = SortType.Rarity
var current_btn: Button = null

func _ready() -> void:
	buttons = [rarity_button, type_button, cost_button]
	
	if ui_string == null:
		ui_string = CardGame.languagePack.get_ui_string("CardLibSortHeader")
		header_texts = ui_string.TEXT

	initialize()

func _process(_delta: float) -> void:
	for button in buttons:
		if button == current_btn or button.is_hovered():
			button.self_modulate = ThemeHelper.top_panel_font_pressed_color
		else:
			button.self_modulate = Color.WHITE

func initialize() -> void:
	var text_indices: Array = [SortType.Rarity, SortType.Type, SortType.Cost]
	for i in range(buttons.size()):
		var text_index = text_indices[i]
		buttons[i].toggle_mode = true
		buttons[i].alignment = HORIZONTAL_ALIGNMENT_CENTER
		buttons[i].text = header_texts[text_index]
		buttons[i].icon = arrow_up if buttons[i].button_pressed else arrow_down
		buttons[i].icon_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		ThemeHelper.apply_top_panel_font_style(buttons[i])
		buttons[i].toggled.connect(_on_tab_btn_toggled.bind(buttons[i]))
		buttons[i].mouse_entered.connect(_on_tab_btn_mouse_entered)

func reset() -> void:
	if not rarity_button.button_pressed:
		rarity_button.button_pressed = true
	else:
		rarity_button.toggled.emit(rarity_button.button_pressed)
	
func _on_tab_btn_toggled(toggled: bool, btn: Button) -> void:
	CardGame.sound.single_play("UI_CLICK_1", -0.2)
	if btn == rarity_button:
		current_sort_type = SortType.Rarity
		sort.emit(SortType.Rarity, toggled)
	elif btn == type_button:
		current_sort_type = SortType.Type
		sort.emit(SortType.Type, toggled)
	elif btn == cost_button:
		current_sort_type = SortType.Cost
		sort.emit(SortType.Cost, toggled)
	current_btn = btn
	btn.icon = arrow_up if toggled else arrow_down
	# for button in buttons:
	# 	button.self_modulate = ThemeHelper.top_panel_font_pressed_color if button == btn else Color.WHITE

func _on_tab_btn_mouse_entered() -> void:
	CardGame.sound.single_play("UI_HOVER", -0.3)