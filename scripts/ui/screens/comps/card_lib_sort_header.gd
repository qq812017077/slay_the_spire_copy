class_name CardLibSortHeader
extends Control

static var ui_string : UIString = null
static var header_texts: Array = []

enum SortHeaderText {Rarity=0, Type=1, Cost=3}
@export var arrow_up: Texture2D = null
@export var arrow_down: Texture2D = null
@export var rarity_button: Button = null
@export var type_button: Button = null
@export var cost_button: Button = null

var buttons: Array[Button] = []
var arrows: Array[TextureRect] = []
func _ready() -> void:
	buttons = [rarity_button, type_button, cost_button]
	for btn in buttons:
		arrows.append(btn.find_child("Arrow") as TextureRect)
	# var button_names : Array = ["CardRarity", "CardType", "CardCost"]

	print(buttons)
	if ui_string == null:
		ui_string = CardGame.languagePack.get_ui_string("CardLibSortHeader")
		header_texts = ui_string.TEXT

	initialize()



func initialize() -> void:
	var text_indices : Array = [SortHeaderText.Rarity, SortHeaderText.Type, SortHeaderText.Cost]
	for i in range(buttons.size()):
		var text_index = text_indices[i]
		buttons[i].alignment = HORIZONTAL_ALIGNMENT_CENTER
		buttons[i].text = header_texts[text_index]
		buttons[i].icon = arrow_up
		buttons[i].icon_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		ThemeHelper.apply_top_panel_font_style(buttons[i])
