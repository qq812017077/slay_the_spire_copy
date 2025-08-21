class_name EventDialog
extends Control

const WORD_TIME: float = 0.02
const CHAR_SPACING: float = 8.0
const LINE_SPACING: float = 38.0
const DIALOG_MSG_X_TEXT: float = 455.0
const DIALOG_MSG_Y_TEXT: float = 712.0
const DIALOG_MSG_W_TEXT: float = 1000.0
const OPTION_SPACING: float = 5.0

const DIALOG_MSG_X = DIALOG_MSG_X_TEXT
const DIALOG_MSG_Y = DIALOG_MSG_Y_TEXT
const DIALOG_MSG_W = DIALOG_MSG_W_TEXT

# @export var rich_text_label: RichTextLabel = null
@export var rich_text_transition_label: RichTextTransitionLabel = null
@export var options_container: Control = null

var options: Array[DialogOptionButton] = []

var word_timer: float = 0
var text_done: bool = true
var a_effect: RichTextTransitionLabel.AppearEffect = RichTextTransitionLabel.AppearEffect.NONE

func _ready() -> void:
	size = Vector2(DIALOG_MSG_W, DIALOG_MSG_Y)
	text_done = true
	if rich_text_transition_label == null:
		rich_text_transition_label = RichTextTransitionLabel.new()
		add_child(rich_text_transition_label)

	ThemeHelper.apply_rich_label_font_style_with_settings(rich_text_transition_label, ThemeHelper.char_desc_label_settings, ThemeHelper.CREAM_COLOR)

func _process(delta: float) -> void:
	body_text_effect(delta)
	animate_in(delta)

func animate_in(_delta: float) -> void:
	pass

func update_body_text(_text: String, ae: RichTextTransitionLabel.AppearEffect = RichTextTransitionLabel.AppearEffect.BUMP_IN) -> void:
	
	a_effect = ae
	text_done = false
	rich_text_transition_label.update_text_with_appear(_text, a_effect)

func body_text_effect(delta: float) -> void:
	word_timer -= delta
	if word_timer < 0 and not rich_text_transition_label.is_done():
		if Settings.FAST_MODE:
			word_timer = 0.005
		else:
			word_timer = 0.02
		
		rich_text_transition_label.display_next_word()


# func create_dialog_text(text: String, _a_effect: DialogText.AppearEffect, effect: DialogText.TextEffect, color: DialogText.TextColor, cur_len_width: float, cur_line: int) -> DialogText:
# 	var word: DialogText = DialogText.new()
	
# 	var pos: Vector2 = Vector2(DIALOG_MSG_X + cur_len_width, DIALOG_MSG_Y + LINE_SPACING * cur_line)
# 	word.load_config(ThemeHelper.char_desc_label_settings, text, _a_effect, effect, color, pos, cur_line)
# 	add_child(word)
# 	return word


func add_dialog_option(option: DialogOptionButton) -> void:
	option.slot = options.size()
	option.name = "option_" + option.option_desc.text
	options.append(option)
	options_container.add_child(option)

func update_dialog_option(slot: int, option: DialogOptionButton) -> void:
	if slot < options.size():
		options[slot].queue_free()
		options[slot] = option
		option.slot = slot
		options_container.add_child(option)
		options_container.move_child(option, slot)
	else:
		add_dialog_option(option)

func refresh_dialog_options_positions() -> void:
	var offset: int = options.size() - 1
	for i in range(options.size()):
		var option: DialogOptionButton = options[i]
		option.position.y = 0 - (DialogOptionButton.TEXT_BODY_HEIGHT + OPTION_SPACING) * offset
		offset -= 1

func clear_dialog_options() -> void:
	for option in options:
		option.queue_free()
	options.clear()

func clear_dialog() -> void:
	pass
# static func identify_word_color(word: String) -> DialogText.TextColor:
# 	if word[0] == "#":
# 		match word[1]:
# 			"r":
# 				return DialogText.TextColor.RED
# 			"g":
# 				return DialogText.TextColor.GREEN
# 			"b":
# 				return DialogText.TextColor.BLUE
# 			"y":
# 				return DialogText.TextColor.GOLD
# 			"p":
# 				return DialogText.TextColor.PURPLE
	
# 	return DialogText.TextColor.DEFAULT

# static func identify_word_effect(word: String) -> DialogText.TextEffect:
# 	var word_len: int = word.length()
# 	if word_len > 2:
# 		if word[0] == "@" and word[word_len - 1] == "@":
# 			return DialogText.TextEffect.SNAKY
# 		if word[0] == "~" and word[word_len - 1] == "~":
# 			return DialogText.TextEffect.WAVY
	
# 	return DialogText.TextEffect.NONE
# static func split(s: String, delimeters: Array, allow_empty: bool = true) -> Array[String]:
# 	var parts: Array[String] = []
	
# 	var start := 0
# 	var i := 0
	
# 	while i < s.length():
# 		if s[i] in delimeters:
# 			if allow_empty or start < i:
# 				parts.push_back(s.substr(start, i - start))
# 			start = i + 1
# 		i += 1
	
# 	if allow_empty or start < i:
# 		parts.push_back(s.substr(start, i - start))
	
# 	return parts