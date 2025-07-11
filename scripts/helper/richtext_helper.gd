class_name RichTextHelper
extends Object

static func render_smart_text(richlabel: RichTextLabel, msg: String, line_width: float) -> void:
	richlabel.text = ""
	var font: Font = richlabel.get_theme_font("normal_font", "RichTextLabel")
	var font_size: int = richlabel.get_theme_font_size("normal_font_size", "RichTextLabel")
	var base_color: Color = richlabel.get_theme_color("default_color", "RichTextLabel")

	var space_size = font.get_string_size(" ", HorizontalAlignment.HORIZONTAL_ALIGNMENT_LEFT, -1, font_size)
	var line_height = space_size.y
	var orb_width = AbstractCard.CARD_ENERGY_IMG_WIDTH

	var cur_width: float = 0
	var cur_height: float = 0
	var color: Color
	# print("msg:", msg)
	for word in msg.split(" "):
		if word.length() == 0:
			continue
		if word == "NL":
			richlabel.newline()
			cur_width = 0
			cur_height += line_height
		elif word == "TAB":
			# richlabel.append_text(tab)
			richlabel.push_indent(1)
			cur_width += space_size.x * richlabel.tab_size
		else:
			var orb = identify_orb(word)
			if orb == null:
				color = identify_color(word)
				if color != Color.WHITE:
					word = word.substr(2)
					color.a = base_color.a
				var split_lines: Array = split_words_to_lines(word, cur_width, line_width, font, font_size)
				var line_count = split_lines.size()
				
				if color != Color.WHITE:
					var i = 1
					for line in split_lines:
						var cur_line_str: String = line[0]
						var cur_line_width: float = line[1]
						richlabel.append_text("[color=#" + color.to_html() + "]" + cur_line_str + "[/color]")
						if i != line_count:
							richlabel.newline()
							cur_width = 0
							cur_height += line_height
						else:
							cur_width += cur_line_width
						i += 1
					# print("append:", word)
				else:
					var i = 1
					for line in split_lines:
						var cur_line_str: String = line[0]
						var cur_line_width: float = line[1]
						richlabel.append_text(cur_line_str)
						if i != line_count:
							richlabel.newline()
							cur_width = 0
							cur_height += line_height
						else:
							cur_width += cur_line_width
						i += 1
					# print("append:", word)
			else:
				if richlabel.get_content_width() + orb_width > line_width:
					richlabel.newline()
				richlabel.add_image(AbstractCard.get_cached_small_orb_texture_from_region(orb),
				int(orb_width), int(orb_width))
				cur_width += orb_width
	richlabel.custom_minimum_size = Vector2(line_width, cur_height + line_height)
	richlabel.size = Vector2(line_width, cur_height + line_height)


static func split_words_to_lines(word: String, cur_width: float, line_width: float, font: Font, font_size: int) -> Array:
	var left_width: float = font.get_string_size(word, HorizontalAlignment.HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x
	var split_lines: Array = [] # element: [string(text), float(width)]
	var left_len: int = word.length()
	var cur_idx: int = 0
	while cur_width + left_width > line_width:
		var split_width: float = max(line_width - cur_width, 0)
		var split_str_len: int = int(left_len * split_width / left_width)
		split_lines.append([word.substr(cur_idx, split_str_len), split_width])
		
		cur_width = 0
		cur_idx += split_str_len
		left_len -= split_str_len
		left_width -= split_width
	if cur_idx < word.length():
		split_lines.append([word.substr(cur_idx), left_width])
	
	var removeLines: Array = []
	for i in range(split_lines.size()):
		# split_lines[i][0] is text's content
		# split_lines[i][1] is text's length
		if split_lines[i][0] == LocalizedString.PERIOD or split_lines[i][0] == LocalizedString.COMMA:
			split_lines[i - 1][0] += split_lines[i][0]
			split_lines[i - 1][1] += split_lines[i][1]
			removeLines.append(i)
	for removeline in removeLines:
		split_lines.remove_at(removeline)
	return split_lines


static func safe_render_smart_text(richlabel: RichTextLabel, msg: String, line_width: float) -> void:
	richlabel.text = ""
	var font: Font = richlabel.get_theme_font("normal_font", "RichTextLabel")
	var font_size: int = richlabel.get_theme_font_size("normal_font_size", "RichTextLabel")
	var base_color: Color = richlabel.get_theme_color("default_color", "RichTextLabel")

	var space_size = font.get_string_size(" ", HorizontalAlignment.HORIZONTAL_ALIGNMENT_LEFT, -1, font_size)
	var line_height = space_size.y
	var orb_width = AbstractCard.CARD_ENERGY_IMG_WIDTH

	var cur_width: float = 0
	var cur_height: float = 0
	var color: Color
	for word in msg.split(" "):
		if word.length() == 0:
			continue
		if word == "NL":
			richlabel.newline.call_deferred()
			cur_width = 0
			cur_height += line_height
		elif word == "TAB":
			# richlabel.append_text(tab)
			richlabel.push_indent.call_deferred(1)
			cur_width += space_size.x * richlabel.tab_size
		else:
			var orb = identify_orb(word)
			if orb == null:
				color = identify_color(word)
				if color != Color.WHITE:
					word = word.substr(2)
					color.a = base_color.a
				var split_lines: Array[String] = split_words_to_lines(word, cur_width, line_width, font, font_size)
				var line_count = split_lines.size()
				
				if color != Color.WHITE:
					var i = 1
					for line in split_lines:
						richlabel.append_text.call_deferred("[color=#" + color.to_html() + "]" + line + "[/color]")
						if i != line_count:
							richlabel.newline.call_deferred()
							cur_width = 0
							cur_height += line_height
						i += 1
					# print("append:", word)
				else:
					var i = 1
					for line in split_lines:
						richlabel.append_text.call_deferred(line)
						if i != line_count:
							richlabel.newline.call_deferred()
							cur_width = 0
							cur_height += line_height
						i += 1
					# print("append:", word)
			else:
				if richlabel.get_content_width() + orb_width > line_width:
					richlabel.newline.call_deferred()
				richlabel.add_image.call_deferred(AbstractCard.get_cached_small_orb_texture_from_region(orb),
				int(orb_width), int(orb_width))
				cur_width += orb_width
	richlabel.custom_minimum_size = Vector2(line_width, cur_height + line_height)
	richlabel.size = Vector2(line_width, cur_height + line_height)

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
