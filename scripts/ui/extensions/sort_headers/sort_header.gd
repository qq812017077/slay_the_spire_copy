class_name SortHeader
extends Control


static var ui_string: UIString = null
static var TEXT: Array = []

enum SortType {Rarity = 0, Type = 1, Cost = 3, ObtaingOrder = 5}

signal sort(sort_type: SortType, descending_order: bool)

@export var arrow_up: Texture2D = null
@export var arrow_down: Texture2D = null

var buttons: Array[Button] = []
var sort_types: Array[SortType] = []
var current_sort_type: SortType = SortType.Rarity
var current_btn: Button = null


func _ready() -> void:
	if ui_string == null:
		ui_string = CardGame.languagePack.get_ui_string("CardLibSortHeader")
		TEXT = ui_string.TEXT

	if arrow_up == null:
		arrow_up = ImageMaster.arrow_up
	if arrow_down == null:
		arrow_down = ImageMaster.arrow_down
	buttons = collect_buttons()
	sort_types = collect_sort_types()

	initialize_buttons(collect_btn_names())

func _process(_delta: float) -> void:
	for button in buttons:
		if button == current_btn or button.is_hovered():
			button.self_modulate = ThemeHelper.top_panel_font_pressed_color
		else:
			button.self_modulate = Color.WHITE

func collect_buttons() -> Array[Button]:
	return []

func collect_sort_types() -> Array[SortType]:
	return []

func collect_btn_names() -> Array[String]:
	return []

func initialize_buttons(btn_names: Array[String]) -> void:
	for i in range(buttons.size()):
		buttons[i].toggle_mode = true
		buttons[i].alignment = HORIZONTAL_ALIGNMENT_CENTER
		buttons[i].text = btn_names[i]
		buttons[i].icon = arrow_up if buttons[i].button_pressed else arrow_down
		buttons[i].icon_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		ThemeHelper.apply_top_panel_font_style(buttons[i])
		buttons[i].toggled.connect(_on_tab_btn_toggled.bind(buttons[i]))
		buttons[i].mouse_entered.connect(_on_tab_btn_mouse_entered)

func reset() -> void:
	if buttons.size() > 0:
		current_btn = buttons[0]
		if not current_btn.button_pressed:
			current_btn.set_pressed_no_signal(true)
		_update_btn_state(current_btn, true)

func _on_tab_btn_toggled(toggled: bool, btn: Button) -> void:
	CardGame.sound.single_play("UI_CLICK_1", -0.2)
	_update_btn_state(btn, toggled)

func _update_btn_state(btn: Button, toggled: bool):
	var btn_idx = buttons.find(btn)
	if btn_idx == -1:
		return
	current_sort_type = sort_types[btn_idx]
	current_btn = btn
	btn.icon = arrow_up if toggled else arrow_down
	sort.emit(current_sort_type, toggled)

func _on_tab_btn_mouse_entered() -> void:
	CardGame.sound.single_play("UI_HOVER", -0.3)
