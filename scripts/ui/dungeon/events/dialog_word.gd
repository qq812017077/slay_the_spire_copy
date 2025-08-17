class_name DialogWord
extends Label

enum AppearEffect {NONE, FADE_IN, GROW_IN, BUMP_IN}
enum WordEffect {NONE, WAVY, SLOW_WAVY, SNAKY, PULSE}
enum WordColor {DEFAULT, RED, GREEN, BLUE, GOLD, PURPLE, WHITE}

const BUMP_OFFSET: float = 20.0
const COLOR_LERP_SPEED: float = 2.0
const SHAKE_AMT: float = 2.0
const DIALOG_FADE_Y: float = 50.0

const WAVY_DIST: float = 3.0
const SHAKE_INTERNAL: float = 0.02
const TARGET_SCALE: Vector2 = Vector2.ONE
var a_effect: AppearEffect
var effect: WordEffect


var line: int
var pos: Vector2
var offset: Vector2 = Vector2.ZERO
var target_pos: Vector2

var timer: float
var target_alpha: float = 1.0
func load_config(label_setting: LabelSettings, content: String, _a_effect: AppearEffect, _effect: WordEffect, _wcolor: WordColor, _pos: Vector2, _line: int):
	ThemeHelper.apply_label_font_style_with_settings(self, label_setting, get_color(_wcolor))
	text = content
	line = _line
	pos = _pos
	target_pos = _pos
	a_effect = _a_effect
	effect = _effect
	modulate.a = 0
	target_alpha = 1.0
	if effect == WordEffect.WAVY or effect == WordEffect.SLOW_WAVY:
		timer = randf_range(0, 1.5707964)

	match a_effect:
		AppearEffect.FADE_IN:
			return
		AppearEffect.GROW_IN:
			pos.y += BUMP_OFFSET
			scale = Vector2.ZERO
		AppearEffect.BUMP_IN:
			pos.y += BUMP_OFFSET

func _process(delta: float) -> void:
	pos = MathHelper.vec2_lerp_snap(pos, target_pos, delta * 12.0)
	modulate.a = MathHelper.lerp_snap(modulate.a, target_alpha, delta * 8.0)
	scale = MathHelper.vec2_lerp_snap(scale, TARGET_SCALE, delta * 8.0)


	apply_effects(delta)
	position = pos + offset

func apply_effects(delta: float) -> void:
	match effect:
		WordEffect.SNAKY:
			timer -= delta
			if timer < 0:
				offset.x = randf_range(-SHAKE_AMT, SHAKE_AMT)
				offset.y = randf_range(-SHAKE_AMT, SHAKE_AMT)
				timer = 0.02
		WordEffect.WAVY:
			timer += delta * 6.0
			offset.y = cos(timer) * 3.0
		WordEffect.SLOW_WAVY:
			timer += delta * 3.0
			offset.y = cos(timer) * 1.5

func dialog_fade_out() -> void:
	target_alpha = 0.0
	target_pos.y += DIALOG_FADE_Y

func shift_y(shift_amount: float) -> void:
	target_pos.y -= shift_amount

func shift_x(shift_amount: float) -> void:
	target_pos.x += shift_amount

func set_x(x: float) -> void:
	target_pos.x = x


static func get_color(wcolor: WordColor) -> Color:
	match wcolor:
		WordColor.RED:
			return ThemeHelper.RED_TEXT_COLOR
		WordColor.GREEN:
			return ThemeHelper.GREEN_TEXT_COLOR
		WordColor.BLUE:
			return ThemeHelper.BLUE_TEXT_COLOR
		WordColor.GOLD:
			return ThemeHelper.GOLD_COLOR
		WordColor.PURPLE:
			return ThemeHelper.PURPLE_COLOR
	return ThemeHelper.CREAM_COLOR

static func identify_word_color(word: String) -> WordColor:
	if word[0] == "#":
		match word[1]:
			"r":
				return WordColor.RED
			"g":
				return WordColor.GREEN
			"b":
				return WordColor.BLUE
			"y":
				return WordColor.GOLD
			"p":
				return WordColor.PURPLE
	
	return WordColor.DEFAULT

static func identify_word_effect(word: String) -> WordEffect:
	var word_len: int = word.length()
	if word_len > 2:
		if word[0] == "@" and word[word_len - 1] == "@":
			return WordEffect.SNAKY
		if word[0] == "~" and word[word_len - 1] == "~":
			return WordEffect.WAVY
	
	return WordEffect.NONE
