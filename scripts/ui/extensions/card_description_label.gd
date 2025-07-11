#
#	UI Control for displaying a card's description
#
@tool
class_name CardDescriptionLabel
extends Control

var desc_normal_label_setting: LabelSettings = null
var desc_keyword_label_setting: LabelSettings = null
static var cached_orb_textures_by_region: Dictionary = {}

var font: Font = null:
	get = get_font, set = set_font
var font_size: int = 16:
	get = get_font_size

var card: AbstractCard = null
var draw_command_lines: Array = []
var orb_size: Vector2
func apply_style(use_large = false) -> void:
	if desc_normal_label_setting == null:
		desc_normal_label_setting = LabelSettings.new()
		desc_normal_label_setting.font = ThemeHelper.get_regular_font()
		desc_normal_label_setting.font_size = ThemeHelper.get_card_desc_font_size(use_large)
		desc_normal_label_setting.font_color = ThemeHelper.card_desc_normal_color
		desc_normal_label_setting.shadow_color = ThemeHelper.card_desc_shadow_color
		desc_normal_label_setting.shadow_offset = ThemeHelper.large_card_desc_shadow_offset if use_large else ThemeHelper.card_desc_shadow_offset
	if desc_keyword_label_setting == null:
		desc_keyword_label_setting = LabelSettings.new()
		desc_keyword_label_setting.font = ThemeHelper.get_regular_font()
		desc_keyword_label_setting.font_size = ThemeHelper.get_card_desc_font_size(use_large)
		desc_keyword_label_setting.font_color = ThemeHelper.card_desc_keyword_color
		desc_keyword_label_setting.shadow_color = ThemeHelper.card_desc_shadow_color
		desc_keyword_label_setting.shadow_offset = ThemeHelper.large_card_desc_shadow_offset if use_large else ThemeHelper.card_desc_shadow_offset

	if use_large:
		orb_size = Vector2(AbstractCard.CARD_ENERGY_IMG_WIDTH * 2.5, AbstractCard.CARD_ENERGY_IMG_WIDTH * 2.5)
	else:
		orb_size = Vector2(AbstractCard.CARD_ENERGY_IMG_WIDTH * 1.5, AbstractCard.CARD_ENERGY_IMG_WIDTH * 1.5)
func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE

func load_card(_card: AbstractCard) -> void:
	if _card == null:
		push_error("Card is null, cannot load.")
		return
	self.card = _card
	build_draw_commands()

func build_draw_commands() -> void:
	draw_command_lines.clear()
	if Settings.lineBreakViaCharacter:
		for desc_line in card.descriptions:
			var draw_commands: Array[DrawCommand] = []
			var tokens: Array[String] = desc_line.get_cached_tokenized_text_cn()
			generate_draw_commands_cn(tokens, draw_commands)
			draw_command_lines.append(draw_commands)
	else:
		for desc_line in card.descriptions:
			var draw_commands: Array[DrawCommand] = []
			var tokens: Array[String] = desc_line.get_cached_tokenized_text()
			generate_draw_commands(tokens, draw_commands)
			draw_command_lines.append(draw_commands)
	
	queue_redraw()

func _draw() -> void:
	if card == null:
		# print("Card is null in CardDescriptionLabel")
		return
	draw_description()


func draw_description() -> void:
	if card == null:
		return
	var current_draw_location: Vector2 = Vector2(0, 0)
	var token_size: Vector2 = Vector2(0, 0)
	if Settings.lineBreakViaCharacter:
		for draw_commands in draw_command_lines:
			# draw line
			current_draw_location.x = 0
			var total_width: float = 0.0
			for command in draw_commands:
				total_width += command.size.x
			var offset: Vector2 = Vector2(size.x - total_width, (size.y - draw_commands[0].size.y * card.descriptions.size()) * 0.25) * 0.5
			for command in draw_commands:
				token_size = command.size
				command.draw_command(self, current_draw_location + offset)
				current_draw_location.x += token_size.x
			current_draw_location.y += token_size.y * ThemeHelper.card_desc_line_height_scale
	else:
			current_draw_location.y += token_size.y

func generate_draw_commands(tokens: Array[String], commands: Array[DrawCommand]) -> void:
	push_error("generate_draw_commands is not implemented in CardDescriptionLabel. Please implement it in the subclass.")
	for token in tokens:
		if token.length() > 0 && token[0] == "*":
			var token2 = token.substr(1)
			var punctuation: String = ""
			if token2.length() > 1 and token2[token2.length() - 2] != '+' and not CharacterHelper.is_letter(token2[token2.length() - 2]):
				var punctuation2: String = token2[token2.length() - 2]
				token2 = token2.substr(0, token2.length() - 2)
				punctuation = punctuation2 + " "
			print("render token2: ", token2, " with punctuation: ", punctuation)
		elif token.length() == 0 || token[0] != "!":
			if token == "[R]" || token == "[B]" || token == "[D]" || token == "[M]":
				print("Render energy orb")
				commands.append(TextureDrawCommand.new(get_cached_orb_texture(), orb_size))
			else:
				commands.append(TextDrawCommand.new(token, desc_normal_label_setting, true))
		elif token.length() == 4:
			print("token: ", token, "'s length is 4")
		elif token.length() == 5:
			print("token: ", token, "'s length is 5")
		else:
			print("other situation. token: ", token)
		
func generate_draw_commands_cn(tokens: Array[String], commands: Array[DrawCommand]) -> void:
	commands.clear()
	for token in tokens:
		var updated_token: String = ""
		# do twice 
		for c in 2:
			var updated = false
			updated_token = ""
			for i in range(token.length()):
				if token[i] == 'D' || (token[i] == 'B' && !token.contains("[B]")) || token[i] == 'M':
					var dynamic_info: DynamicValueInfo = card.get_dynamic_value_info(token[i])
					if dynamic_info.is_modified:
						var pre = token.substr(0, i)
						if pre.length() > 0:
							commands.append(TextDrawCommand.new(pre, desc_normal_label_setting, true, false))
						commands.append(TextDrawCommand.new(dynamic_info.value, desc_normal_label_setting, true, false, {
							"font_color": dynamic_info.modified_color
						}))
						updated_token = token.substr(i + 1)
						updated = true
					else:
						updated_token = token.substr(0, i) + card.get_dynamic_value(token[i]) + token.substr(i + 1)
						updated = true
					break
			if updated:
				token = updated_token
		if token.length() > 0 && token[0] == '*':
			var token2: String = token.substr(1)
			var token2_len: int = token2.length()
			var punctuation: String = ""
			if token2_len > 1 && token2[token2_len - 2] != '+' && not CharacterHelper.is_letter(token2[token2_len - 2]):
				var punctuation2: String = token2[token2_len - 2]
				token2 = token2.substr(0, token2_len - 2)
				punctuation = punctuation2 + " "
			commands.append(TextDrawCommand.new(token2, desc_keyword_label_setting, true))
			if punctuation.length() > 0:
				commands.append(TextDrawCommand.new(punctuation, desc_normal_label_setting, true))
		elif token == "[R]" || token == "[B]" || token == "[G]" || token == "[W]":
			commands.append(TextureDrawCommand.new(get_cached_orb_texture(), orb_size))
		elif token.length() > 0:
			commands.append(TextDrawCommand.new(token, desc_normal_label_setting, true, false))
	
################################################
# Getters and Setters for properties
################################################

func get_font() -> Font:
	if font == null:
		return ThemeDB.fallback_font
	return font
	
func set_font(value: Font) -> void:
	font = value
	queue_redraw()

func get_font_size() -> int:
	if font == null:
		return ThemeDB.fallback_font_size
	return font_size

func get_cached_orb_texture() -> AtlasTexture:
	if card == null:
		push_error("Card is null, cannot get orb texture.")
		return null

	var card_cost_orb_texture: AtlasRegion = AbstractCard.get_card_desc_orb(card.color)
	if card_cost_orb_texture == null:
		return null
	if cached_orb_textures_by_region.has(card_cost_orb_texture):
		return cached_orb_textures_by_region[card_cost_orb_texture]

	var cost_orb_atlas_texture: AtlasTexture = AtlasTexture.new()
	cost_orb_atlas_texture.atlas = card_cost_orb_texture.texture
	cost_orb_atlas_texture.region = Rect2(card_cost_orb_texture.xy, card_cost_orb_texture.size)
	cost_orb_atlas_texture.filter_clip = true
	cached_orb_textures_by_region.set(card_cost_orb_texture, cost_orb_atlas_texture)

	return cost_orb_atlas_texture
