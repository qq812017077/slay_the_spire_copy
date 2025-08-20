@tool
class_name RichTextTransitionLabel
extends RichTextLabel

enum AppearEffect {NONE, FADE_IN, GROW_IN, BUMP_IN}
enum TextEffect {NONE, WAVY, SLOW_WAVY, SNAKY, PULSE}
enum TextColor {DEFAULT, RED, GREEN, BLUE, GOLD, PURPLE, WHITE}

var appear_effect: AppearEffect
var text_effect: TextEffect

var char_time: Array = []
var wordlen_stack: Array[int] = []
var loaded_effects: Array[String] = []

var all_together: bool:
	get:
		return visible_characters == -1
var total_text_length: int

var cur_length: int:
	get:
		return total_text_length if visible_characters == -1 else visible_characters
func _process(delta: float) -> void:
	update_visible_chars(delta)

func update_visible_chars(delta: float) -> void:
	for i in range(cur_length):
		char_time[i] = clamp(char_time[i] + delta, 0.0, 1.0)


func get_normal_font() -> Font:
	return get_theme_font("normal_font")


func update_body_text(_text: String, ae: AppearEffect = AppearEffect.FADE_IN) -> void:
	var clean_text: String = _text.strip_edges().replace("\r\n", "\n")
	# split text into words via multiple delimiters
	var words: Array[String] = split(clean_text, [' ', '\n', '\t'])
	
	wordlen_stack.clear()
	clear()
	unload_effects()
	appear_effect = ae

	var global_bbcode_prefix: String = ""
	var global_bbcode_suffix: String = ""
	
	if appear_effect != AppearEffect.NONE:
		load_effect(get_appear_effect(appear_effect))
		global_bbcode_prefix = get_bbcode_appear_prefix(appear_effect)
		global_bbcode_suffix = get_bbcode_appear_suffix(appear_effect)
	
	var content: String = ""
	for word: String in words:
		if word == "NL":
			# newline()
			content += "\n"
			continue
		
		var word_color: TextColor = identify_word_color(word)
		var bbcode_prefix: String = ""
		var bbcode_suffix: String = ""
		if word_color != TextColor.DEFAULT:
			word = word.substr(2)
			bbcode_prefix = bbcode_prefix + get_bbcode_color_prefix(word_color)
			bbcode_suffix = get_bbcode_color_suffix(word_color) + bbcode_suffix
		
		var word_effect: TextEffect = identify_word_effect(word)
		if word_effect != TextEffect.NONE:
			word = word.substr(1, word.length() - 2)
			load_effect(get_text_effect(word_effect))
			bbcode_prefix = bbcode_prefix + get_bbcode_effect_prefix(word_effect)
			bbcode_suffix = get_bbcode_effect_suffix(word_effect) + bbcode_suffix

		var word_len: int = word.length()
		wordlen_stack.push_front(word_len)
		# append_text(bbcode_prefix + word + bbcode_suffix)
		content += bbcode_prefix + word + bbcode_suffix
	
	append_text(global_bbcode_prefix + content + global_bbcode_suffix)
	if appear_effect == AppearEffect.NONE:
		visible_characters = -1
	else:
		visible_characters = 0
		load_effect(get_appear_effect(appear_effect))
	
	refresh_config()

func refresh_config() -> void:
	# for effect: RichTextEffect in custom_effects:
	# 	effect.set_meta("rt", get_instance_id())
	var parsed_text: String = get_parsed_text()
	total_text_length = parsed_text.length()
	char_time.resize(total_text_length)
	for i in range(total_text_length):
		char_time[i] = 0.0


func get_time(char_absolute_idx: int) -> float:
	return clamp(char_time[char_absolute_idx], 0.0, 1.0)

func unload_effects() -> void:
	while custom_effects.size() > 0:
		custom_effects.pop_back()
	loaded_effects.clear()

func load_effect(rt_effect: RichTextEffectBase) -> void:
	if rt_effect == null:
		return
	var bbcode = rt_effect.get("bbcode")
	if bbcode == null:
		return
	if bbcode in loaded_effects:
		return
	
	loaded_effects.push_back(bbcode)
	rt_effect.set_meta("rt", get_instance_id())
	install_effect(rt_effect)

func get_text_effect(effect: TextEffect) -> RichTextEffect:
	match effect:
		TextEffect.SNAKY:
			return ShakyEffect.new()
		TextEffect.WAVY:
			loaded_effects.push_back(TextEffect.SLOW_WAVY)
			return WavyEffect.new()
		TextEffect.SLOW_WAVY:
			loaded_effects.push_back(TextEffect.WAVY)
			return WavyEffect.new()
		TextEffect.PULSE:
			return null
	return null

func get_appear_effect(effect: AppearEffect) -> RichTextEffect:
	match effect:
		AppearEffect.FADE_IN:
			return FadeIn.new()
		AppearEffect.GROW_IN:
			return null
		AppearEffect.BUMP_IN:
			return null
	return null

static func get_bbcode_color_prefix(color: TextColor) -> String:
	match color:
		TextColor.RED:
			return "[color=#FF0000]"
		TextColor.GREEN:
			return "[color=#00FF00]"
		TextColor.BLUE:
			return "[color=#0000FF]"
		TextColor.GOLD:
			return "[color=#FFD700]"
		TextColor.PURPLE:
			return "[color=#800080]"
		TextColor.WHITE:
			return "[color=#FFFFFF]"
	return ""

static func get_bbcode_color_suffix(color: TextColor) -> String:
	if color == TextColor.DEFAULT:
		return ""
	return "[/color]"

static func get_bbcode_effect_prefix(effect: TextEffect) -> String:
	match effect:
		TextEffect.SNAKY:
			return "[shaky]"
		TextEffect.WAVY:
			return "[wavy]"
		TextEffect.SLOW_WAVY:
			return "[wavy slow=true]"
		TextEffect.PULSE:
			return "[pulse]"
	return ""

static func get_bbcode_effect_suffix(effect: TextEffect) -> String:
	match effect:
		TextEffect.SNAKY:
			return "[/shaky]"
		TextEffect.WAVY:
			return "[/wavy]"
		TextEffect.SLOW_WAVY:
			return "[/wavy]"
		TextEffect.PULSE:
			return "[/pulse]"
	return ""

static func get_bbcode_appear_prefix(effect: AppearEffect) -> String:
	match effect:
		AppearEffect.FADE_IN:
			return "[fade_in]"
		AppearEffect.GROW_IN:
			return "[grow_in]"
		AppearEffect.BUMP_IN:
			return "[bump_in]"
	return ""

static func get_bbcode_appear_suffix(effect: AppearEffect) -> String:
	match effect:
		AppearEffect.FADE_IN:
			return "[/fade_in]"
		AppearEffect.GROW_IN:
			return "[/grow_in]"
		AppearEffect.BUMP_IN:
			return "[/bump_in]"
	return ""
static func identify_word_color(word: String) -> TextColor:
	if word[0] == "#":
		match word[1]:
			"r":
				return TextColor.RED
			"g":
				return TextColor.GREEN
			"b":
				return TextColor.BLUE
			"y":
				return TextColor.GOLD
			"p":
				return TextColor.PURPLE
	
	return TextColor.DEFAULT

static func identify_word_effect(word: String) -> TextEffect:
	var word_len: int = word.length()
	if word_len > 2:
		if word[0] == "@" and word[word_len - 1] == "@":
			return TextEffect.SNAKY
		if word[0] == "~" and word[word_len - 1] == "~":
			return TextEffect.WAVY
	
	return TextEffect.NONE

static func split(s: String, delimeters: Array, allow_empty: bool = true) -> Array[String]:
	var parts: Array[String] = []
	
	var start := 0
	var i := 0
	
	while i < s.length():
		if s[i] in delimeters:
			if allow_empty or start < i:
				parts.push_back(s.substr(start, i - start))
			start = i + 1
		i += 1
	
	if allow_empty or start < i:
		parts.push_back(s.substr(start, i - start))
	
	return parts