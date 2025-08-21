@tool
class_name RichTextTransitionLabel
extends RichTextLabelEx

enum AppearEffect {NONE, FADE_IN, GROW_IN, BUMP_IN}

var appear_effect: AppearEffect
var char_time: Array = []

var all_together: bool:
	get:
		return visible_characters == -1
var total_text_length: int

var cur_length: int:
	get:
		return total_text_length if visible_characters == -1 else visible_characters
var next_display_idx: int = 0

func is_done() -> bool:
	return visible_characters == -1

func _process(delta: float) -> void:
	update_visible_chars(delta)
	
func update_visible_chars(delta: float) -> void:
	for i in range(cur_length):
		char_time[i] = clamp(char_time[i] + delta, 0.0, 1.0)


func update_text(raw_text: String) -> void:
	update_text_with_appear(raw_text, AppearEffect.FADE_IN)

func display_next_word() -> void:
	if next_display_idx >= parsed_words.size():
		return
	visible_characters += parsed_words[next_display_idx].length()
	if visible_characters == total_text_length:
		visible_characters = -1
	next_display_idx += 1


func update_text_with_appear(raw_text: String, ae : AppearEffect):
	clear()
	unload_effects()

	appear_effect = ae

	var global_bbcode_prefix: String = ""
	var global_bbcode_suffix: String = ""
	
	if appear_effect != AppearEffect.NONE:
		load_effect(get_appear_effect(appear_effect))
		global_bbcode_prefix = get_bbcode_appear_prefix(appear_effect)
		global_bbcode_suffix = get_bbcode_appear_suffix(appear_effect)
	
	var bbcode: String = generate_bbcode(raw_text)
	# print("final:", global_bbcode_prefix + bbcode + global_bbcode_suffix)
	append_text(global_bbcode_prefix + bbcode + global_bbcode_suffix)

	reset()

func reset() -> void:
	var parsed_text: String = get_parsed_text()
	total_text_length = parsed_text.length()
	# var parsed_word: String = ""
	# for word in parsed_words:
	# 	parsed_word += word
	# print("parsed_text:", parsed_text)
	# print("parsed_word:", parsed_word)
	# print("total_text_length:{0}   parsed_length:{1}".format([total_text_length, parsed_word.length()]))
	char_time.resize(total_text_length)
	for i in range(total_text_length):
		char_time[i] = 0.0

	next_display_idx = 0

	if appear_effect == AppearEffect.NONE:
		visible_characters = -1
	else:
		visible_characters = 0

func get_time(char_absolute_idx: int) -> float:
	return clamp(char_time[char_absolute_idx], 0.0, 1.0)


func get_appear_effect(effect: AppearEffect) -> RichTextEffect:
	match effect:
		AppearEffect.FADE_IN:
			return FadeEffect.new()
		AppearEffect.GROW_IN:
			return GrowEffect.new()
		AppearEffect.BUMP_IN:
			return BumpEffect.new()
	push_error("unknown appear effect:", AppearEffect.find_key(effect))
	return null


static func get_bbcode_appear_prefix(effect: AppearEffect) -> String:
	match effect:
		AppearEffect.FADE_IN:
			return "[fadein]"
		AppearEffect.GROW_IN:
			return "[growin]"
		AppearEffect.BUMP_IN:
			return "[bumpin]"
	return ""

static func get_bbcode_appear_suffix(effect: AppearEffect) -> String:
	match effect:
		AppearEffect.FADE_IN:
			return "[/fadein]"
		AppearEffect.GROW_IN:
			return "[/growin]"
		AppearEffect.BUMP_IN:
			return "[/bumpin]"
	return ""