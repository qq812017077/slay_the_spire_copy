@tool
class_name SmartLabel
extends Control

@export var line_break_via_character: bool = false
@export_multiline var text: String = "":
	set = set_text, get = get_text


@export var label_setting: LabelSettings = LabelSettings.new()
@export var line_spacing: int = 3

var command_lines: Array = []
var space_width: float = 0
var line_height: float = 0:
	set = set_line_height, get = get_line_height
func _ready() -> void:
	if label_setting == null:
		label_setting = LabelSettings.new()
	if label_setting.font == null:
		label_setting.font = load("res://arts/slay_the_spire/fonts/card_desc_font.tres")
	refresh_data()

	# line_break_via_character = Settings.lineBreakViaCharacter
	
func refresh_data() -> void:
	var space_size = label_setting.font.get_string_size(" ", HORIZONTAL_ALIGNMENT_LEFT, -1, label_setting.font_size)
	space_width = space_size.x
	line_height = space_size.y + float(line_spacing)

func _draw() -> void:
	refresh_data()

	if line_break_via_character:
		render_non_word_wrapped_text()
	else:
		var line_width = size.x
		var cur_width: float = 0
		var cur_height: float = 0
		for line_commands in command_lines:
			for command : DrawCommand in line_commands:
				if cur_width + command.size.x > line_width:
					cur_height += line_height
					cur_width = 0
				command.draw_command(self, Vector2(cur_width, cur_height))
				cur_width += command.size.x
			cur_height += line_height
			cur_width = 0

func render_non_word_wrapped_text() -> void:
	var line_width = size.x
	var cur_width: float = 0
	var cur_height: float = 0
	var color = label_setting.font_color
	var command: DrawCommand = null
	for line in text.split("\n"):
		for word in line.split(" "):
			if word.length() == 0:
				continue
			if word == "NL":
				cur_width = 0
				cur_height += line_height
			elif word == "TAB":
				cur_width += space_width
			elif word[0] == '[':
				var orb = identify_orb(word)
				command = TextureDrawCommand.new(orb, Vector2(AbstractCard.CARD_ENERGY_IMG_WIDTH, AbstractCard.CARD_ENERGY_IMG_WIDTH))
			elif word[0] == '#':
				match word[1]:
					'r':
						color = Color.hex(0xff6563ff)
					'g':
						color = Color.hex(0x7fff00ff)
					'b':
						color = Color.hex(0x87ceebff)
					'y':
						color = Color.hex(0xefc851ff)
					'p':
						color = Color.hex(0x0e82eeff)
				word = word.substr(2)
				command = TextDrawCommand.new(word, label_setting, true, true, {"font_color": color})
			else:
				command = TextDrawCommand.new(word, label_setting, true, true)
			if cur_width + command.size.x > line_width:
					cur_height += line_height
					cur_width = 0
			command.draw_command(self, Vector2(cur_width, cur_height))
			cur_width += command.size.x + space_width

func generate_commands() -> void:
	if line_break_via_character:
		render_non_word_wrapped_text()
	else:
		command_lines = []
		var color = label_setting.font_color
		for line in text.split("\n"):
			var commands : Array[DrawCommand] = []
			for word in line.split(" "):
				if word == "NL":
					if commands.size() > 0:
						command_lines.append(commands)
						commands = []
				elif word == "TAB":
					commands.append(TextDrawCommand.new("     ", label_setting))
				else:
					var orb = identify_orb(word)
					if orb == null:
						color = identify_color(word)
						if color != Color.WHITE:
							word = word.substr(2)
							color.a = label_setting.font_color.a
						else:
							color = label_setting.font_color
						commands.append(TextDrawCommand.new(word, label_setting, true, true, {"font_color": color}))
					else:
						commands.append(TextureDrawCommand.new(orb, Vector2(AbstractCard.CARD_ENERGY_IMG_WIDTH, AbstractCard.CARD_ENERGY_IMG_WIDTH)))
			if commands.size() > 0:
				command_lines.append(commands)
	
	# 提前绘制号，否则会在某一帧产生巨大开销
	_draw()
func set_text(val: String) -> void:
	text = val
	
func get_text() -> String:
	return text

func set_line_height(val: float) -> void:
	line_height = val
	# queue_redraw()
func get_line_height() -> float:
	return line_height


static func identify_orb(word) -> AtlasRegion:
	match word:
		"[E]":
			return AbstractCard.orb_red
		"[R]":
			return AbstractCard.orb_red
		"[G]":
			return AbstractCard.orb_green
		"[B]":
			return AbstractCard.orb_blue
		"[W]":
			return AbstractCard.orb_purple
		"[C]":
			return AbstractCard.orb_card
		"[P]":
			return AbstractCard.orb_potion
		"[T]":
			return AbstractCard.orb_relic
		"[S]":
			return AbstractCard.orb_special
	return null

static func identify_color(word: String) -> Color:
	if word.length() > 0 and word[0] == '#':
		match word[1]:
			"r":
				return ThemeHelper.RED_TEXT_COLOR
			"g":
				return ThemeHelper.GREEN_TEXT_COLOR
			"b":
				return ThemeHelper.BLUE_TEXT_COLOR
			"y":
				return ThemeHelper.GOLD_COLOR
			"p":
				return ThemeHelper.PURPLE_COLOR
	return Color.WHITE
