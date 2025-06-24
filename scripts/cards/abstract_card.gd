class_name AbstractCard
extends Object


enum CardColor {RED, GREEN, BLUE, PURPLE, COLORLESS, CURSE}
enum CardRarity {BASIC, SPECIAL, COMMON, UNCOMMON, RARE, CURSE}
enum CardTarget{NONE, ENEMY, SELF, ALL_ENEMIES, SELF_AND_ENEMY, ALL}
enum CardType {ATTACK, SKILL, POWER, STATUS, CURSE}
enum CardTag {HEALING, STRIKE, EMPTY, STARTER_DEFEND, STARTER_STRIKE}
##
## Static Variables
##
static var COLOR_ENERGY = {
	CardColor.RED: "[R]",
	CardColor.GREEN: "[G]",
	CardColor.BLUE: "[B]",
	CardColor.PURPLE: "[W]",
	CardColor.COLORLESS: "[W]"
}
static var COMMON_CARD_PRICE: int = 50
static var UNCOMMON_CARD_PRICE: int = 100
static var RARE_CARD_PRICE: int = 200

# 
static var DESC_CHARACTER_WIDTH: float = 0.0
static var IMG_WIDTH: float = 0.0
static var IMG_HEIGHT: float = 0.0
static var CN_DESC_BOX_WIDTH: float = 0.0
static var TITLE_BOX_WIDTH: float = 0.0
static var TITLE_BOX_WIDTH_NO_COST: float = 0.0
static var CARD_ENERGY_IMG_WIDTH: float = 0.0

# Card Color
static var FRAME_SHADOW_COLOR: Color = Color(0, 0, 0, 0.25)
static var IMG_FRAME_COLOR_COMMON: Color = CardHelper.get_color(53, 58, 64)
static var IMG_FRAME_COLOR_UNCOMMON: Color = CardHelper.get_color(119, 152, 161)
static var IMG_FRAME_COLOR_RARE: Color = Color(0.855, 0.557, 0.32, 1.0)
static var BANNER_COLOR_COMMON: Color = CardHelper.get_color(131, 129, 121)
static var BANNER_COLOR_UNCOMMON: Color = CardHelper.get_color(142, 196, 213)
static var BANNER_COLOR_RARE: Color = Color(1.0, 0.796, 0.251, 1.0)
static var CURSE_BG_COLOR: Color = CardHelper.get_color(29, 29, 29)
static var CURSE_BACK_COLOR: Color = Color(0.23, 0.23, 0.23, 1.0)
static var CURSE_FRAME_COLOR: Color = CardHelper.get_color(21, 2, 21)
static var CURSE_DESC_BOX_COLOR: Color = CardHelper.get_color(52, 58, 64)
static var COLORLESS_BG_COLOR: Color = Color(0.12, 0.12, 0.12, 1.0)
static var COLORLESS_BACK_COLOR: Color = Color(0.23, 0.23, 0.23, 1.0)
static var COLORLESS_FRAME_COLOR: Color = Color(0.48, 0.48, 0.48, 1.0)
static var COLORLESS_DESC_BOX_COLOR: Color = Color(0.351, 0.363, 0.3745, 1.0)
static var RED_BG_COLOR: Color = CardHelper.get_color(50, 26, 26)
static var RED_BACK_COLOR: Color = CardHelper.get_color(91, 43, 32)
static var RED_FRAME_COLOR: Color = CardHelper.get_color(121, 12, 28)
static var RED_RARE_OUTLINE_COLOR: Color = Color(1.0, 0.75, 0.43, 1.0)
static var RED_DESC_BOX_COLOR: Color = CardHelper.get_color(53, 58, 64)

static var card_atlas: TextureAtlas = null
static var orb_atlas: TextureAtlas = null

static var orb_red: AtlasRegion = null
static var orb_green: AtlasRegion = null
static var orb_blue: AtlasRegion = null
static var orb_purple: AtlasRegion = null
static var orb_card: AtlasRegion = null
static var orb_potion: AtlasRegion = null
static var orb_relic: AtlasRegion = null
static var orb_special: AtlasRegion = null

static var ui_string : UIString = null

static var desc_label_by_card_id: Dictionary = {}

var card_id: String
var type: CardType
var target: CardTarget
var rarity: CardRarity
var color: CardColor

var times_upgrades: int = 0
var upgraded: bool = false
var cost: int = -1
var price: int = -1
var retain: bool = false
var self_retain: bool = false

var misc: int = 0 	# Miscellaneous value, used for various purposes like showing the number of cards in a deck.
var is_innate: bool = false	# If true, the card is played at the start of the turn.
var exhaust: bool = false	# If true, the card is removed from the deck after use.

var damage_type: DamageInfo.DamageType
# 数值
var base_damage: int = -1
var base_block: int = -1
var base_heal: int = -1
var base_magic_number: int = -1

var is_damage_modified: bool = false
var is_block_modified: bool = false
var is_magic_number_modified: bool = false

var damage: int = -1
var block: int = -1
var magic_number: int = -1

var is_multi_damage: bool = false 
var shuffle_back_into_draw_pile: bool = false

var is_ethereal: bool = false # If true, the card is removed from the deck after use, but can be played again.
# evoke
var show_evoke_value: bool = false
var show_evoke_orb_count: int = -1
# 
var bg_color: Color
var back_color: Color
var frame_color: Color
var frame_outline_color: Color
var frame_shadow_color: Color
var img_frame_color: Color
var desc_box_color: Color
var banner_color: Color
var tint_color: Color

var keywords: Array[String] = []

var originalName: String                 = ""
var name: String                         = ""
var descriptions: Array[DescriptionLine] = []
var rawDescription: String               = ""
var img_url: String = ""
var portrait: AtlasRegion = null


var card_to_preview:AbstractCard = null
var tags: Array[CardTag] = []

var card_description_label: CardDescriptionLabel = null
# 静态初始化
static func init_static():
	# Initialize static variables or perform any static setup here
	pass


#########################################################################
# functions for outer use
#########################################################################

func _init(id: String, _name: String, _imgUrl: String, _cost: int, _rawDescription: String, _type: CardType,
_color: CardColor, _rarity: CardRarity, _target: CardTarget, dType: DamageInfo.DamageType=DamageInfo.DamageType.NORMAL) -> void:
	self.card_id = id
	self.name = _name
	self.originalName = _name
	self.img_url = _imgUrl
	self.portrait = card_atlas.find_region(_imgUrl)
	if self.portrait == null:
		self.portrait = card_atlas.find_region("status/beta");
	
	self.cost = _cost
	self.rawDescription = _rawDescription
	self.type = _type
	self.color = _color
	self.rarity = _rarity
	self.target = _target
	self.damage_type = dType
	
	self.retain = false
	self.upgraded = false

	self.initialize_color()
	self.initialize_description()
	self.card_description_label = get_cached_description_label(self)

func upgrade() -> void:
	pass

func use(_player, _monster) -> void:
	pass
#					
#	get card info
# 
func get_card_type()-> String:
	match self.type:
		CardType.ATTACK:
			return ui_string.TEXT[0]
		CardType.SKILL:
			return ui_string.TEXT[1]
		CardType.POWER:
			return ui_string.TEXT[2]
		CardType.STATUS:
			return ui_string.TEXT[7]
		CardType.CURSE:
			return ui_string.TEXT[3]
	return ui_string.TEXT[5]

func get_card_bg()-> AtlasRegion:
	match self.type:
		CardType.ATTACK:
			return get_attack_bg()
		CardType.SKILL:
			return get_skill_bg()
		CardType.POWER:
			return get_power_bg()
		CardType.STATUS:
			return get_skill_bg()
		CardType.CURSE:
			return get_skill_bg()
		_:
			return null
#
#	get card portrait
# 
func get_portrait()-> AtlasRegion:
	return portrait
#
#	get card portrait frame
# 
func get_portrait_frame()-> AtlasRegion:
	match self.type:
		CardType.ATTACK:
			return get_attack_portrait()
		CardType.SKILL:
			return get_skill_portrait()
		CardType.POWER:
			return get_power_portrait()
		CardType.STATUS:
			return get_skill_portrait()
		CardType.CURSE:
			return get_skill_portrait()
		_:
			return null

func get_banner_image() -> AtlasRegion:
	if self.rarity == CardRarity.UNCOMMON:
		return ImageMaster.card_banner_uncommon
	elif self.rarity == CardRarity.RARE:
		return ImageMaster.card_banner_rare
	else:
		return ImageMaster.card_banner_common


func get_card_back() -> AtlasRegion:
	return ImageMaster.card_back

func get_description() -> Array[DescriptionLine]:
	return self.descriptions

func get_description_label() -> CardDescriptionLabel:
	return self.card_description_label
#########################################################################
# Static functions
#########################################################################
static func initialize():
	IMG_WIDTH = 300.0 * Settings.scale
	IMG_HEIGHT = 420.0 * Settings.scale

	CN_DESC_BOX_WIDTH = IMG_WIDTH * 0.97 if Settings.BIG_TEXT_MODE else IMG_WIDTH * 0.85
	CARD_ENERGY_IMG_WIDTH = 24.0 * Settings.scale
	# load default font
	if Settings.lineBreakViaCharacter:
		DESC_CHARACTER_WIDTH = ThemeHelper.normal_font_zhs.get_string_size("一").x
	else:
		DESC_CHARACTER_WIDTH = ThemeHelper.normal_font_zhs.get_string_size("a").x
	
	ui_string = CardGame.languagePack.get_ui_string("SingleCardViewPopup")
	
	# initialize atlas all needed
	var cards_atlas_path: String = "res://arts/slay_the_spire/images/cards/cards.atlas"
	var orb_atlas_path: String = "res://arts/slay_the_spire/images/orbs/orb.atlas"
	
	# load atlas data to 
	card_atlas = TextureAtlas.load(cards_atlas_path)
	orb_atlas = TextureAtlas.load(orb_atlas_path)
	orb_red = orb_atlas.find_region("red");
	orb_green = orb_atlas.find_region("green");
	orb_blue = orb_atlas.find_region("blue");
	orb_purple = orb_atlas.find_region("purple");
	orb_card = orb_atlas.find_region("card");
	orb_potion = orb_atlas.find_region("potion");
	orb_relic = orb_atlas.find_region("relic");
	orb_special = orb_atlas.find_region("special");

static func get_card_desc_orb(card_color: CardColor) -> AtlasRegion:
	match card_color:
		CardColor.RED:
			return orb_red
		CardColor.GREEN:
			return orb_green
		CardColor.BLUE:
			return orb_blue
		CardColor.PURPLE:
			return orb_purple

	# push_error("Unknown card color: %s" % card_color)
	return orb_purple

static func get_card_cost_orb(card_color: CardColor) -> AtlasRegion:
	match card_color:
		CardColor.RED:
			return ImageMaster.card_red_orb
		CardColor.GREEN:
			return ImageMaster.card_green_orb
		CardColor.BLUE:
			return ImageMaster.card_blue_orb
		CardColor.PURPLE:
			return ImageMaster.card_purple_orb
		CardColor.COLORLESS:
			return ImageMaster.card_colorless_orb
		CardColor.CURSE:
			return ImageMaster.card_colorless_orb
	return null
##############################
# functions for inner use
##############################
func initialize_color():
	match self.color:
		CardColor.RED:
			self.bg_color = RED_BG_COLOR
			self.back_color = RED_BACK_COLOR
			self.frame_color = RED_FRAME_COLOR
			self.frame_outline_color = RED_RARE_OUTLINE_COLOR
			self.desc_box_color = RED_DESC_BOX_COLOR
		CardColor.GREEN:
			# Initialize green card colors here
			pass
		CardColor.BLUE:
			# Initialize blue card colors here
			pass
		CardColor.PURPLE:
			# Initialize purple card colors here
			pass
		CardColor.COLORLESS:
			self.bg_color = COLORLESS_BG_COLOR
			self.back_color = COLORLESS_BACK_COLOR
			self.frame_color = COLORLESS_FRAME_COLOR
			self.frame_outline_color = Color(0.5, 0.5, 0.5, 1.0)
			self.desc_box_color = COLORLESS_DESC_BOX_COLOR
	
	if self.rarity == CardRarity.COMMON or self.rarity == CardRarity.COMMON or self.rarity == CardRarity.CURSE:
		self.banner_color = BANNER_COLOR_COMMON
		self.img_frame_color = IMG_FRAME_COLOR_COMMON
	elif self.rarity == CardRarity.UNCOMMON:
		self.banner_color = BANNER_COLOR_UNCOMMON
		self.img_frame_color = IMG_FRAME_COLOR_UNCOMMON
	else:
		self.banner_color = BANNER_COLOR_RARE
		self.img_frame_color = IMG_FRAME_COLOR_RARE
	
	self.tint_color = CardHelper.get_color(43, 37, 65)
	self.frame_shadow_color = FRAME_SHADOW_COLOR


func initialize_description() -> void:
	# Initialize the card description here
	# This could involve setting a label or text field with the card's raw description
	self.keywords.clear()
	
	if Settings.lineBreakViaCharacter:
		self.initialize_description_cn()
		return 
	
#	var split :Array[String]
	self.descriptions.clear();

func initialize_description_cn():
	
	self.descriptions.clear()
	var numLines: int = 0
	# string buffer
	var line_str: String = ""
	var splits: PackedStringArray = self.rawDescription.split(" ")
	for word: String in splits:
		if word == "":
			continue
		# trim word
		var word2: String = word.strip_edges()
		if Settings.manualLineBreak or Settings.manualAndAutoLineBreak or !word2.contains("NL"):
			if (word2 != "NL" or line_str.length() != 0) && !word2.is_empty():
				var keyword_tmp: String = dedupe_keyword(word2.to_lower())
				if GameDictionary.keywords.has(keyword_tmp):
					if not self.keywords.has(keyword_tmp):
						self.keywords.append(keyword_tmp)

					if ThemeHelper.get_desc_string_size_cn(line_str).x + DESC_CHARACTER_WIDTH > CN_DESC_BOX_WIDTH:
						numLines+=1
						self.descriptions.append(DescriptionLine.new(line_str, ThemeHelper.get_desc_string_size_cn(line_str)))
						line_str = ""
					line_str += " *" + word2 + " "
				elif not word2.is_empty() && word2[0] == "[":
					var target_energy = COLOR_ENERGY[self.color]
					if not self.keywords.has(target_energy):
						self.keywords.append(target_energy)
					if ThemeHelper.get_desc_string_size_cn(line_str).x + CARD_ENERGY_IMG_WIDTH > CN_DESC_BOX_WIDTH:
						numLines+=1
						self.descriptions.append(DescriptionLine.new(line_str, ThemeHelper.get_desc_string_size_cn(line_str)))
						line_str = ""
					line_str += " " + word2 + " "
				elif word2 == "!D!":
					if ThemeHelper.get_desc_string_size_cn(line_str).x + DESC_CHARACTER_WIDTH > CN_DESC_BOX_WIDTH:
						numLines+=1
						self.descriptions.append(DescriptionLine.new(line_str, ThemeHelper.get_desc_string_size_cn(line_str)))
						line_str = ""
					line_str += " D "
				elif word2 == "!B!" or word2 == "!M!":
					if ThemeHelper.get_desc_string_size_cn(line_str).x + DESC_CHARACTER_WIDTH > CN_DESC_BOX_WIDTH:
						numLines+=1
						self.descriptions.append(DescriptionLine.new(line_str, ThemeHelper.get_desc_string_size_cn(line_str)))
						line_str = ""
					line_str += " " + word2 + "! "
				elif (Settings.manualLineBreak || Settings.manualAndAutoLineBreak) && word2 == "NL" && line_str.length() != 0:
					numLines+=1
					self.descriptions.append(DescriptionLine.new(line_str, ThemeHelper.get_desc_string_size_cn(line_str)))
					line_str = ""
				elif word2[0] == '*':
					if ThemeHelper.get_desc_string_size_cn(line_str).x + DESC_CHARACTER_WIDTH > CN_DESC_BOX_WIDTH:
						numLines+=1
						self.descriptions.append(DescriptionLine.new(line_str, ThemeHelper.get_desc_string_size_cn(line_str)))
						line_str = ""
					line_str += " " + word2 + " "
				else:
					for c in word2:
						line_str += c
						if not Settings.manualLineBreak and ThemeHelper.get_desc_string_size_cn(line_str).x + DESC_CHARACTER_WIDTH > CN_DESC_BOX_WIDTH:
							numLines+=1
							self.descriptions.append(DescriptionLine.new(line_str, ThemeHelper.get_desc_string_size_cn(line_str)))
							line_str = ""
	if line_str.length() > 0:
		numLines+=1
		self.descriptions.append(DescriptionLine.new(line_str, ThemeHelper.get_desc_string_size_cn(line_str)))
		line_str = ""
	var removeLine: int = -1;
	for i in range(self.descriptions.size()):
		if self.descriptions[i].text == LocalizedString.PERIOD:
			var descriptionLine : DescriptionLine = self.descriptions[i-1]
			descriptionLine.text += LocalizedString.PERIOD
			removeLine = i;
	if removeLine != -1:
		self.descriptions.remove_at(removeLine)
	
	if numLines > 5:
		push_error("WARNING: Card " + name + " has lots of text");

	
func dedupe_keyword(keyword: String) -> String:
	var retVal = GameDictionary.parent_word.get(keyword);
	return retVal if retVal != null else keyword

func get_dynamic_value(value) -> String:
	match value:
		'B':
			if not self.is_block_modified:
				return str(self.base_block)
			if self.block > self.base_block:
				return "[#7fff00]" + str(self.block) + "[]"
			return "[#ff6563]" + str(self.block) + "[]"

		'D':
			if not self.is_damage_modified:
				return str(self.base_damage)
			if self.damage > self.base_damage:
				return "[#7fff00]" + str(self.damage) + "[]"
			return "[#ff6563]" + str(self.damage) + "[]"
		'M':
			if not self.is_magic_number_modified:
				return str(self.base_magic_number)
			if self.magic_number > self.base_magic_number:
				return "[#7fff00]" + str(self.magic_number) + "[]"
			return "[#ff6563]" + str(self.magic_number) + "[]"
	
	push_error("value: " + value)
	return str(-99)

func get_attack_bg() -> AtlasRegion:
	match self.color:
		CardColor.RED:
			return ImageMaster.card_attack_bg_red
		CardColor.GREEN:
			return ImageMaster.card_attack_bg_green
		CardColor.BLUE:
			return ImageMaster.card_attack_bg_blue
		CardColor.PURPLE:
			return ImageMaster.card_attack_bg_purple
		CardColor.COLORLESS:
			return ImageMaster.card_attack_bg_colorless
		_:
			push_error("Unknown card color: %s" % self.color)
			return null

func get_skill_bg() -> AtlasRegion:
	match self.color:
		CardColor.RED:
			return ImageMaster.card_skill_bg_red
		CardColor.GREEN:
			return ImageMaster.card_skill_bg_green
		CardColor.BLUE:
			return ImageMaster.card_skill_bg_blue
		CardColor.PURPLE:
			return ImageMaster.card_skill_bg_purple
		CardColor.COLORLESS:
			return ImageMaster.card_skill_bg_colorless
		CardColor.CURSE:
			return ImageMaster.card_skill_bg_black
		_:
			push_error("Unknown card color: %s" % self.color)
			return null

func get_power_bg() -> AtlasRegion:
	match self.color:
		CardColor.RED:
			return ImageMaster.card_power_bg_red
		CardColor.GREEN:
			return ImageMaster.card_power_bg_green
		CardColor.BLUE:
			return ImageMaster.card_power_bg_blue
		CardColor.PURPLE:
			return ImageMaster.card_power_bg_purple
		CardColor.COLORLESS:
			return ImageMaster.card_power_bg_colorless
		_:
			push_error("Unknown card color: %s" % self.color)
			return null

func get_attack_portrait() -> AtlasRegion:
	if self.rarity == CardRarity.UNCOMMON:
		return ImageMaster.card_frame_attack_uncommon
	if self.rarity == CardRarity.RARE:
		return ImageMaster.card_frame_attack_rare
	return ImageMaster.card_frame_attack_common

func get_skill_portrait() -> AtlasRegion:
	if self.rarity == CardRarity.UNCOMMON:
		return ImageMaster.card_frame_skill_uncommon
	if self.rarity == CardRarity.RARE:
		return ImageMaster.card_frame_skill_rare
	return ImageMaster.card_frame_skill_common

func get_power_portrait() -> AtlasRegion:
	if self.rarity == CardRarity.UNCOMMON:
		return ImageMaster.card_frame_power_uncommon
	if self.rarity == CardRarity.RARE:
		return ImageMaster.card_frame_power_rare
	return ImageMaster.card_frame_power_common


static func get_cached_description_label(_card : AbstractCard) -> CardDescriptionLabel:
	if not desc_label_by_card_id.has(_card.card_id):
		desc_label_by_card_id.set(_card.card_id, CardDescriptionLabel.new(_card))

	return desc_label_by_card_id[_card.card_id]
