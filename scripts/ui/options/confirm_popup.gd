class_name ConfirmPopup
extends Control

static var ui_string: UIString = null
static var TEXT: Array = []

@export var title: Label = null
@export var desc: Label = null
@export var yes_button: Button = null
@export var no_button: Button = null

var yes_click_event: Callable
var no_click_event: Callable


func _ready() -> void:
	if ui_string == null:
		ui_string = CardGame.languagePack.get_ui_string("ConfirmPopup")
		TEXT = ui_string.TEXT
	
	title.text = CardGame.languagePack.get_ui_string("SettingsScreen").TEXT[0]
	
	yes_button.text = TEXT[2]
	no_button.text = TEXT[3]
	yes_button.pressed.connect(_yes_clicked)
	no_button.pressed.connect(_no_clicked)
	yes_button.mouse_entered.connect(_on_mouse_entered.bind($Yes))
	yes_button.mouse_exited.connect(_on_mouse_exited.bind($Yes))
	no_button.mouse_entered.connect(_on_mouse_entered.bind($No))
	no_button.mouse_exited.connect(_on_mouse_exited.bind($No))

	ThemeHelper.apply_card_title_font_style(title)
	ThemeHelper.apply_panel_info_font_style(desc)

	ThemeHelper.apply_confirm_button_style(yes_button)
	ThemeHelper.apply_confirm_button_style(no_button)
	

func open(_desc: String, yes_event: Callable, no_event: Callable) -> void:
	self.show()
	desc.text = _desc
	yes_click_event = yes_event
	no_click_event = no_event

func _yes_clicked() -> void:
	self.hide()
	CardGame.sound.single_play("UI_CLICK_1", -0.3)
	if yes_click_event.is_valid():
		yes_click_event.call()

func _no_clicked() -> void:
	self.hide()
	CardGame.sound.single_play("UI_CLICK_1", -0.3)
	if no_click_event.is_valid():
		no_click_event.call()

func _on_mouse_entered(tex: TextureRect) -> void:
	# print("entered:", tex.name)
	if tex:
		tex.self_modulate = Color.WHITE * 1.5

func _on_mouse_exited(tex: TextureRect) -> void:
	# print("exited:", tex.name)
	if tex:
		tex.self_modulate = Color.WHITE
