class_name CardDescriptionRichTextLabel
extends RichTextLabel

static var cached_orb_textures_by_region: Dictionary = {}

var card: AbstractCard = null

var font: Font
var font_size: int
var orb_size: Vector2

func _ready() -> void:
	set_anchors_preset(PRESET_FULL_RECT)

func apply_style(use_large = false) -> void:
	ThemeHelper.initialize_richtextlabel_style(self)
	font = ThemeHelper.get_regular_font()
	font_size = ThemeHelper.get_card_desc_font_size(use_large)
	ThemeHelper.apply_rich_label_font_style_with(self, {
		"normal_font": font,
		"normal_font_size": font_size,
		"default_color": ThemeHelper.card_desc_normal_color,
		"font_outline_color": Color.TRANSPARENT,
		"outline_size": 0,
		"font_shadow_color": ThemeHelper.card_desc_shadow_color,
		"shadow_offset_x": ThemeHelper.large_card_desc_shadow_offset.x if use_large else ThemeHelper.card_desc_shadow_offset.x,
		"shadow_offset_y": ThemeHelper.large_card_desc_shadow_offset.y if use_large else ThemeHelper.card_desc_shadow_offset.y,
		"line_separation": - 10,
	})
	
	if use_large:
		orb_size = Vector2(AbstractCard.CARD_ENERGY_IMG_WIDTH * 2.5, AbstractCard.CARD_ENERGY_IMG_WIDTH * 2.5)
	else:
		orb_size = Vector2(AbstractCard.CARD_ENERGY_IMG_WIDTH * 1.5, AbstractCard.CARD_ENERGY_IMG_WIDTH * 1.5)

func load_card(_card: AbstractCard) -> void:
	if _card == null:
		push_error("Card is null, cannot load.")
		return
	self.card = _card
	generate_text()

func generate_text() -> void:
	text = ""
	if Settings.lineBreakViaCharacter:
		for desc_line in card.descriptions:
			var tokens: Array[String] = desc_line.get_cached_tokenized_text_cn()
			for token in tokens:
				var updated_token: String = ""
				# do twice 
				for c in 2:
					updated_token = ""
					for i in range(token.length()):
						if token[i] == 'D' || (token[i] == 'B' && !token.contains("[B]")) || token[i] == 'M':
							updated_token = token.substr(0, i) + card.get_dynamic_value(token[i]) + token.substr(i + 1)
							break
					if updated_token != "":
						token = updated_token
				if token.length() > 0 && token[0] == '*':
					var token2: String = token.substr(1)
					var token2_len: int = token2.length()
					var punctuation: String = ""
					if token2_len > 1 && token2[token2_len - 2] != '+' && not CharacterHelper.is_letter(token2[token2_len - 2]):
						var punctuation2: String = token2[token2_len - 2]
						token2 = token2.substr(0, token2_len - 2)
						punctuation = punctuation2 + " "
					append_text("[color=#d9b64c]" + token2 + "[/color]")
					if punctuation.length() > 0:
						add_text(punctuation)
				elif token == "[R]" || token == "[B]" || token == "[G]" || token == "[W]":
					add_image(AbstractCard.get_cached_small_orb_texture(card), int(orb_size.x))
				else:
					append_text(token)
			newline()
	else:
		for desc_line in card.descriptions:
			var tokens: Array[String] = desc_line.get_cached_tokenized_text()
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
						add_image(AbstractCard.get_cached_small_orb_texture(card), int(orb_size.x))
					else:
						add_text(token)
				elif token.length() == 4:
					print("token: ", token, "'s length is 4")
				elif token.length() == 5:
					print("token: ", token, "'s length is 5")
				else:
					print("other situation. token: ", token)

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