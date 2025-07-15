class_name SingleCardViewPopup
extends Control

const HIGHLIGHT = Color.WHITE * 1.5
const NORMAL = Color.WHITE

static var ui_string: UIString
static var TEXT: Array

@export var black_bg: Control = null
@export var upgrade_toggle: TickToggle = null
@export_group("Prefabs")
@export var attack_card_large: CardWidget = null
@export var skill_card_large: CardWidget = null
@export var power_card_large: CardWidget = null
@export_group("")

@export_group("Arrow Buttons")
@export var pre_arrow: TextureRect = null
@export var next_arrow: TextureRect = null
@export_group("")
@export_group("Tips")
@export var tip_container: Control = null
@export_group("")
@export_group("Preview")
@export var preview_container: Control = null
@export_group("")
var card_library_screen: CardLibraryScreen = null
var black_alpha = 0
var cur_widget_large: CardWidget = null
var current_list: Array
var cur_widget_index: int = 0

var tooltips: Array = []
var preview: CardWidget = null

func _ready() -> void:
	if ui_string == null:
		ui_string = CardGame.languagePack.get_ui_string("SingleCardViewPopup")
		TEXT = ui_string.TEXT
	
	z_index = Global.SINGLE_POPUP_Z_INDEX
	pre_arrow.gui_input.connect(_on_arrow_gui_input.bind(pre_arrow))
	next_arrow.gui_input.connect(_on_arrow_gui_input.bind(next_arrow))

	pre_arrow.mouse_entered.connect(_on_arrow_mouse_entered.bind(pre_arrow))
	pre_arrow.mouse_exited.connect(_on_arrow_mouse_exited.bind(pre_arrow))
	
	next_arrow.mouse_entered.connect(_on_arrow_mouse_entered.bind(next_arrow))
	next_arrow.mouse_exited.connect(_on_arrow_mouse_exited.bind(next_arrow))

	upgrade_toggle.set_text(TEXT[6])
	upgrade_toggle.set_hover_color(ThemeHelper.BLUE_TEXT_COLOR)
	upgrade_toggle.set_normal_color(ThemeHelper.GOLD_COLOR)
	upgrade_toggle.set_toggle_style({"font_size": 28, "font_outline_size": 16})

	upgrade_toggle.button.toggled.connect(_on_upgrade_toggle_button_clicked)

	gui_input.connect(_on_gui_input)

func _process(delta: float) -> void:
	if not visible:
		return
	black_bg.self_modulate.a = MathHelper.lerp_snap(black_bg.self_modulate.a, 0.8, delta * 10)

func open(cardwidget: CardWidget, card_list: Array, upgrade: bool = false) -> void:
	cur_widget_index = card_list.find(cardwidget)
	upgrade_toggle.button.button_pressed = upgrade
	current_list = card_list
	visible = true
	load_card(cardwidget.card)
	if card_library_screen:
		card_library_screen.mouse_filter = Control.MOUSE_FILTER_IGNORE

func close() -> void:
	# recycle
	recycle_tip_and_preview()

	visible = false
	current_list = []
	cur_widget_index = -1
	black_bg.self_modulate.a = 0
	if card_library_screen:
		card_library_screen.upgrade_toggle_button.button_pressed = false
		card_library_screen.mouse_filter = Control.MOUSE_FILTER_STOP

func load_card(card: AbstractCard) -> void:
	attack_card_large.visible = false
	skill_card_large.visible = false
	power_card_large.visible = false
	if card.type == AbstractCard.CardType.ATTACK:
		cur_widget_large = attack_card_large
		attack_card_large.load_card(card)
		attack_card_large.visible = true
	elif card.type == AbstractCard.CardType.POWER:
		cur_widget_large = power_card_large
		power_card_large.load_card(card)
		power_card_large.visible = true
	else:
		cur_widget_large = skill_card_large
		skill_card_large.load_card(card)
		skill_card_large.visible = true

	cur_widget_large.display_in_library(upgrade_toggle.button.button_pressed, true)

	refresh_tip_and_preview(cur_widget_large)
	
	pre_arrow.visible = cur_widget_index > 0
	next_arrow.visible = cur_widget_index < (current_list.size() - 1)

func recycle_tip_and_preview() -> void:
	# recycle
	for cardtip in tooltips:
		if cardtip == null:
			continue
		cardtip.clear_content()
		CardGame.tip.recycle_tooltip(cardtip)
	tooltips = []
	if preview != null:
		CardWidget.recycle(preview)
		preview = null

func refresh_tip_and_preview(cardwidget: CardWidget) -> void:
	recycle_tip_and_preview()
	var cur_card = cardwidget.upgraded_card_library if cardwidget.upgraded_card_library else cardwidget.card
	var cur_pos = tip_container.get_global_rect().position
	for keyword in cur_card.keywords:
		if not GameDictionary.keywords.has(keyword):
			continue
		var tooltip: CardTip = CardGame.tip.get_idle_tooltip()
		tooltip.rendering_front(Global.SINGLE_POPUP_Z_INDEX + 1)
		tooltip.set_content(keyword, GameDictionary.keywords[keyword])
		tooltip.visible = true
		tooltip.position = cur_pos
		cur_pos.y += tooltip.get_global_rect().size.y + TipMaster.OFFSET_Y
		tooltips.append(tooltip)
	
	if cur_card.card_to_preview != null:
		preview = CardWidget.allocate_by_type(cur_card.card_to_preview.type)
		preview_container.add_child(preview)
		preview.load_card(cur_card.card_to_preview)
		preview.position = Vector2.ZERO

func _on_arrow_gui_input(event: InputEvent, arrow: TextureRect) -> void:
	if event is InputEventMouseButton:
		var mouse_event: InputEventMouseButton = event as InputEventMouseButton
		if mouse_event.button_index != MOUSE_BUTTON_LEFT:
			return
		
		if mouse_event.is_pressed():
			CardGame.sound.single_play("UI_CLICK_1", -0.2)
			if arrow == pre_arrow:
				if current_list != null:
					cur_widget_index = cur_widget_index - 1
					load_card(current_list[cur_widget_index].card)
			elif arrow == next_arrow:
				if current_list != null:
					cur_widget_index = cur_widget_index + 1
					load_card(current_list[cur_widget_index].card)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event: InputEventMouseButton = event as InputEventMouseButton
		if mouse_event.button_index != MOUSE_BUTTON_LEFT:
			return
		
		if mouse_event.is_pressed():
			# print("popup is pressed, need close!")
			close()

func _on_arrow_mouse_entered(arrow: TextureRect) -> void:
	arrow.self_modulate = HIGHLIGHT

func _on_arrow_mouse_exited(arrow: TextureRect) -> void:
	arrow.self_modulate = NORMAL


func _on_upgrade_toggle_button_clicked(_toggle_on: bool) -> void:
	CardGame.sound.single_play("UI_CLICK_1", -0.2)
	if cur_widget_large:
		cur_widget_large.display_in_library(_toggle_on)
		refresh_tip_and_preview(cur_widget_large)
