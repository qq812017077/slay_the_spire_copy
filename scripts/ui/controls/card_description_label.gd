#
#	UI Control for displaying a card's description
#
@tool
class_name CardDescriptionLabel
extends Control


static var cached_orb_textures_by_region: Dictionary = {}

var font: Font = null:
	get = get_font, set = set_font
var font_size: int = 16:
	get = get_font_size

var card: AbstractCard = null
var draw_command_lines: Array = []

func _init(_card : AbstractCard) -> void:
	card = _card
	
func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE	

	if Settings.lineBreakViaCharacter:
		for desc_line in card.descriptions:
			var draw_commands: Array[TextDrawCommand] = []
			var tokens: Array[String] = desc_line.get_cached_tokenized_text_cn()
			generate_draw_commands_cn(tokens, draw_commands)
			draw_command_lines.append(draw_commands)
	else:
		for desc_line in card.descriptions:
			var draw_commands: Array[TextDrawCommand] = []
			var tokens: Array[String] = desc_line.get_cached_tokenized_text()
			generate_draw_commands(tokens, draw_commands)
			draw_command_lines.append(draw_commands)

func _draw() -> void:
	# print("draw")

	if card == null:
		print("Card is null in CardDescriptionLabel")
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
			var offset: Vector2 = Vector2(size.x - total_width, (size.y - draw_commands[0].size.y * card.descriptions.size()) * 0.25)* 0.5
			for command in draw_commands:
#				token_text.clear()
				# var token_text = TextLine.new()
				token_size = command.size
				if command.is_energy():
					draw_energy(command.token_text, command.texture, current_draw_location + offset, token_size.x)
				else:
					if command.draw_shadow:
						draw_text_with_shadow(command.token_text, current_draw_location + offset, command.desc_color,
						ThemeHelper.card_desc_shadow_offset, ThemeHelper.card_desc_shadow_color,
						token_size.x)
				current_draw_location.x += token_size.x
			current_draw_location.y += token_size.y * ThemeHelper.card_desc_line_height_scale
			
	else:
			current_draw_location.y += token_size.y

func generate_draw_commands(tokens: Array[String], commands:Array[TextDrawCommand])-> void:
	push_error("generate_draw_commands is not implemented in CardDescriptionLabel. Please implement it in the subclass.")
	for token in tokens:
		if token.length() > 0 && token[0] == "*":
			var token2 = token.substr(1)
			var punctuation: String = ""
			if token2.length() > 1 and token2[token2.length()-2] != '+' and not CharacterHelper.is_letter(token2[token2.length()-2]):
				var punctuation2: String = token2[token2.length()-2]
				token2 = token2.substr(0, token2.length()-2)
				punctuation = punctuation2 + " "
			print("render token2: ", token2, " with punctuation: ", punctuation)
		elif token.length() ==0 || token[0]	!= "!":
			if token == "[R]" || token == "[B]" || token == "[D]" || token == "[M]":
				print("Render energy orb")
				commands.append(TextDrawCommand.new(TextDrawCommand.DescTextType.ENERGY, token, true, ThemeHelper.get_desc_string_size(token), card.color))
			else:
				commands.append(TextDrawCommand.new(TextDrawCommand.DescTextType.NORMAL, token, true, ThemeHelper.get_desc_string_size(token), card.color))
		elif token.length() == 4:
			print("token: ", token, "'s length is 4")
		elif token.length() == 5:
			print("token: ", token, "'s length is 5")
		else:
			print("other situation. token: ", token)
		
func generate_draw_commands_cn(tokens: Array[String], commands:Array[TextDrawCommand])-> void:
	commands.clear()
	for token in tokens:
		var updated_token: String = ""
		# do twice 
		for c in 2:
			updated_token = ""
			for i in range(token.length()):
				if token[i] == 'D' || (token[i] == 'B' && !token.contains("[B]")) || token[i] == 'M':
					updated_token = token.substr(0, i) + card.get_dynamic_value(token[i]) + token.substr(i+1)
					break
			if updated_token != "":
				token = updated_token
		if token.length() > 0 && token[0] == '*':
			var token2: String = token.substr(1)
			var token2_len: int = token2.length()
			var punctuation: String = ""
			if token2_len > 1 && token2[token2_len-2] != '+' && not CharacterHelper.is_letter(token2[token2_len-2]):
				var punctuation2: String = token2[token2_len-2]
				token2 = token2.substr(0, token2_len-2)
				punctuation = punctuation2 + " "
			commands.append(TextDrawCommand.new(
				TextDrawCommand.DescTextType.KEYWORD, token2, true, ThemeHelper.get_desc_string_size_cn(token2), card.color))
			if punctuation.length() > 0:
				commands.append(TextDrawCommand.new(
					TextDrawCommand.DescTextType.NORMAL, punctuation, true, ThemeHelper.get_desc_string_size_cn(punctuation), card.color))
			# render token2 and punctuation2

		elif token == "[R]" || token == "[B]" || token == "[G]" || token == "[W]":
			commands.append(TextDrawCommand.new(TextDrawCommand.DescTextType.ENERGY, token, false, 
					Vector2(AbstractCard.CARD_ENERGY_IMG_WIDTH, AbstractCard.CARD_ENERGY_IMG_WIDTH), card.color))
		else:
			commands.append(TextDrawCommand.new(TextDrawCommand.DescTextType.NORMAL, token, true, ThemeHelper.get_desc_string_size_cn(token), card.color))
	
func draw_text_with_shadow(text_line: TextLine, location: Vector2, desc_color: Color, shadow_offset: Vector2, shadow_color:Color, line_width: float = -1) -> void:
	text_line.width = text_line.get_line_width() if line_width <= 0 else line_width
	text_line.draw(get_canvas_item(), location + shadow_offset, shadow_color, 2.0)
	text_line.draw(get_canvas_item(),location, desc_color, 2.0)
	
func draw_energy(text_line: TextLine, texture: AtlasTexture, location: Vector2, line_width: float = -1) -> void:
	text_line.width = text_line.get_line_width() if line_width <= 0 else line_width
	text_line.draw(get_canvas_item(), location)
	var rect: Rect2 = text_line.get_object_rect(texture)
	rect.position += location
	rect.position += Vector2(0, 2)
	draw_texture_rect(texture, rect,false)
################################################
# Getters and Setters for properties
################################################

func  get_font() -> Font:
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

	var card_cost_orb_texture : AtlasRegion = AbstractCard.get_card_desc_orb(card.color)
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
