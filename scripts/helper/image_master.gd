class_name ImageMaster
extends Object

# settings

static var card_ui_atlas: TextureAtlas = null
static var card_back: AtlasRegion = null
static var card_bg: AtlasRegion = null
# bg
static var card_attack_bg_purple: AtlasRegion = null
static var card_skill_bg_purple: AtlasRegion = null
static var card_power_bg_purple: AtlasRegion = null
static var card_purple_orb: AtlasRegion = null
static var card_attack_bg_red: AtlasRegion = null
static var card_skill_bg_red: AtlasRegion = null
static var card_power_bg_red: AtlasRegion = null
static var card_red_orb: AtlasRegion = null
static var card_attack_bg_green: AtlasRegion = null
static var card_skill_bg_green: AtlasRegion = null
static var card_power_bg_green: AtlasRegion = null
static var card_green_orb: AtlasRegion = null
static var card_attack_bg_blue: AtlasRegion = null
static var card_skill_bg_blue: AtlasRegion = null
static var card_power_bg_blue: AtlasRegion = null
static var card_blue_orb: AtlasRegion = null
static var card_attack_bg_colorless: AtlasRegion = null
static var card_skill_bg_colorless: AtlasRegion = null
static var card_power_bg_colorless: AtlasRegion = null
static var card_skill_bg_black: AtlasRegion = null
static var card_colorless_orb: AtlasRegion = null

# frame
static var card_frame_attack_common: AtlasRegion = null
static var card_frame_attack_uncommon: AtlasRegion = null
static var card_frame_attack_rare: AtlasRegion = null
static var card_frame_skill_common: AtlasRegion = null
static var card_frame_skill_uncommon: AtlasRegion = null
static var card_frame_skill_rare: AtlasRegion = null
static var card_frame_power_common: AtlasRegion = null
static var card_frame_power_uncommon: AtlasRegion = null
static var card_frame_power_rare: AtlasRegion = null

# banner
static var card_banner_common: AtlasRegion = null
static var card_banner_uncommon: AtlasRegion = null
static var card_banner_rare: AtlasRegion = null

# large for single card display
# bg large
static var card_attack_bg_purple_large: AtlasRegion = null
static var card_skill_bg_purple_large: AtlasRegion = null
static var card_power_bg_purple_large: AtlasRegion = null
static var card_purple_orb_large: AtlasRegion = null
static var card_attack_bg_red_large: AtlasRegion = null
static var card_skill_bg_red_large: AtlasRegion = null
static var card_power_bg_red_large: AtlasRegion = null
static var card_red_orb_large: AtlasRegion = null
static var card_attack_bg_green_large: AtlasRegion = null
static var card_skill_bg_green_large: AtlasRegion = null
static var card_power_bg_green_large: AtlasRegion = null
static var card_green_orb_large: AtlasRegion = null
static var card_attack_bg_blue_large: AtlasRegion = null
static var card_skill_bg_blue_large: AtlasRegion = null
static var card_power_bg_blue_large: AtlasRegion = null
static var card_blue_orb_large: AtlasRegion = null

static var card_attack_bg_colorless_large: AtlasRegion = null
static var card_skill_bg_colorless_large: AtlasRegion = null
static var card_power_bg_colorless_large: AtlasRegion = null
static var card_skill_bg_black_large: AtlasRegion = null
static var card_colorless_orb_large: AtlasRegion = null

# frame large
static var card_frame_attack_common_large: AtlasRegion = null
static var card_frame_attack_uncommon_large: AtlasRegion = null
static var card_frame_attack_rare_large: AtlasRegion = null
static var card_frame_skill_common_large: AtlasRegion = null
static var card_frame_skill_uncommon_large: AtlasRegion = null
static var card_frame_skill_rare_large: AtlasRegion = null
static var card_frame_power_common_large: AtlasRegion = null
static var card_frame_power_uncommon_large: AtlasRegion = null
static var card_frame_power_rare_large: AtlasRegion = null

# banner large
static var card_banner_common_large: AtlasRegion = null
static var card_banner_uncommon_large: AtlasRegion = null
static var card_banner_rare_large: AtlasRegion = null


# portrait
static var PORTRAIT_STANDARD: Texture2D = null
static var PORTRAIT_DAILY: Texture2D = null
static var PORTRAIT_LOOP: Texture2D = null
static var PORTRAIT_INFO_CARD: Texture2D = null
static var PORTRAIT_INFO_RELIC: Texture2D = null
static var PORTRAIT_INFO_POTION: Texture2D = null
static var PORTRAIT_STAT_CHAR: Texture2D = null
static var PORTRAIT_STAT_HISTORY: Texture2D = null
static var PORTRAIT_STAT_LEADERBOARD: Texture2D = null
static var PORTRAIT_SETTING_GAME: Texture2D = null
static var PORTRAIT_SETTING_INPUT: Texture2D = null
static var PORTRAIT_SETTING_CREDITS: Texture2D = null

# character
static var CHARACTER_SELECT_IRONCLAD: Texture2D = null
static var CHARACTER_SELECT_SILENT: Texture2D = null
static var CHARACTER_SELECT_DEFECT: Texture2D = null
static var CHARACTER_SELECT_WATCHER: Texture2D = null
static var CHARACTER_SELECT_BG_IRONCLAD: Texture2D = null
static var CHARACTER_SELECT_BG_SILENT: Texture2D = null
static var CHARACTER_SELECT_BG_DEFECT: Texture2D = null
static var CHARACTER_SELECT_BG_WATCHER: Texture2D = null

static var UI_GOLD: Texture2D = null
static var TP_HP: Texture2D = null
static var TP_GOLD: Texture2D = null
static var TP_FLOOR: Texture2D = null
static var TP_ASCENSION: Texture2D = null

# map
static var map_node_event: Texture2D = null
static var map_node_event_outline: Texture2D = null
static var map_node_elite: Texture2D = null
static var map_node_elite_outline: Texture2D = null
static var map_node_enemy: Texture2D = null
static var map_node_enemy_outline: Texture2D = null
static var map_node_rest: Texture2D = null
static var map_node_rest_outline: Texture2D = null
static var map_node_treasure: Texture2D = null
static var map_node_treasure_outline: Texture2D = null
static var map_node_merchant: Texture2D = null
static var map_node_merchant_outline: Texture2D = null
static var map_legend: Texture2D = null

static var map_dot: Texture2D = null

static var relic_images: Dictionary = {}
static var relic_outline_images: Dictionary = {}

# enemy
static var boss_level1_gurdian_img: Texture2D = null
static var boss_level1_gurdian_outline: Texture2D = null
static var boss_level1_hexaghost_img: Texture2D = null
static var boss_level1_hexaghost_outline: Texture2D = null
static var boss_level1_slime_img: Texture2D = null
static var boss_level1_slime_outline: Texture2D = null
static var boss_level2_collector_img: Texture2D = null
static var boss_level2_collector_outline: Texture2D = null
static var boss_level2_automaton_img: Texture2D = null
static var boss_level2_automaton_outline: Texture2D = null
static var boss_level2_champ_img: Texture2D = null
static var boss_level2_champ_outline: Texture2D = null
static var boss_level3_awakened_img: Texture2D = null
static var boss_level3_awakened_outline: Texture2D = null
static var boss_level3_timeeater_img: Texture2D = null
static var boss_level3_timeeater_outline: Texture2D = null
static var boss_level3_donu_img: Texture2D = null
static var boss_level3_donu_outline: Texture2D = null
static var boss_level_end_heart_img: Texture2D = null
static var boss_level_end_heart_outline: Texture2D = null
static func initialize() -> void:
	initialize_card_ui()
	initialize_portrait_img()
	initialize_panel_ui()
	initialize_settings_ui()

	initialize_map_ui()

	initialize_enemy_ui()

static func initialize_settings_ui() -> void:
	pass

static func initialize_card_ui() -> void:
	var card_ui_atlas_path: String = "res://arts/slay_the_spire/images/cardui/cardui.atlas"
	card_ui_atlas = TextureAtlas.load(card_ui_atlas_path)
	if card_ui_atlas == null:
		push_error("Failed to load card UI atlas from path: %s" % card_ui_atlas_path)
		return
	card_back = card_ui_atlas.find_region("512/card_back")
	card_bg = card_ui_atlas.find_region("512/card_bg")

	card_attack_bg_purple = card_ui_atlas.find_region("512/bg_attack_purple")
	card_skill_bg_purple = card_ui_atlas.find_region("512/bg_skill_purple")
	card_power_bg_purple = card_ui_atlas.find_region("512/bg_power_purple")
	card_purple_orb = card_ui_atlas.find_region("512/card_purple_orb")

	card_attack_bg_red = card_ui_atlas.find_region("512/bg_attack_red")
	card_skill_bg_red = card_ui_atlas.find_region("512/bg_skill_red")
	card_power_bg_red = card_ui_atlas.find_region("512/bg_power_red")
	card_red_orb = card_ui_atlas.find_region("512/card_red_orb")

	card_attack_bg_green = card_ui_atlas.find_region("512/bg_attack_green")
	card_skill_bg_green = card_ui_atlas.find_region("512/bg_skill_green")
	card_power_bg_green = card_ui_atlas.find_region("512/bg_power_green")
	card_green_orb = card_ui_atlas.find_region("512/card_green_orb")

	card_attack_bg_blue = card_ui_atlas.find_region("512/bg_attack_blue")
	card_skill_bg_blue = card_ui_atlas.find_region("512/bg_skill_blue")
	card_power_bg_blue = card_ui_atlas.find_region("512/bg_power_blue")
	card_blue_orb = card_ui_atlas.find_region("512/card_blue_orb")

	card_attack_bg_colorless = card_ui_atlas.find_region("512/bg_attack_gray")
	card_skill_bg_colorless = card_ui_atlas.find_region("512/bg_skill_gray")
	card_power_bg_colorless = card_ui_atlas.find_region("512/bg_power_gray")
	card_colorless_orb = card_ui_atlas.find_region("512/card_colorless_orb")

	#	CARD_ATTACK_BG_SILHOUETTE = card_ui_atlas.find_region("512/bg_attack_silhouette")
	#	CARD_SKILL_BG_SILHOUETTE = card_ui_atlas.find_region("512/bg_skill_silhouette")
	#	CARD_POWER_BG_SILHOUETTE = card_ui_atlas.find_region("512/bg_power_silhouette")
	card_skill_bg_black = card_ui_atlas.find_region("512/bg_skill_black")
	#	
	card_frame_attack_common = card_ui_atlas.find_region("512/frame_attack_common")
	card_frame_attack_uncommon = card_ui_atlas.find_region("512/frame_attack_uncommon")
	card_frame_attack_rare = card_ui_atlas.find_region("512/frame_attack_rare")
	card_frame_skill_common = card_ui_atlas.find_region("512/frame_skill_common")
	card_frame_skill_uncommon = card_ui_atlas.find_region("512/frame_skill_uncommon")
	card_frame_skill_rare = card_ui_atlas.find_region("512/frame_skill_rare")
	card_frame_power_common = card_ui_atlas.find_region("512/frame_power_common")
	card_frame_power_uncommon = card_ui_atlas.find_region("512/frame_power_uncommon")
	card_frame_power_rare = card_ui_atlas.find_region("512/frame_power_rare")
	card_banner_common = card_ui_atlas.find_region("512/banner_common")
	card_banner_uncommon = card_ui_atlas.find_region("512/banner_uncommon")
	card_banner_rare = card_ui_atlas.find_region("512/banner_rare")

	#	CARD_SUPER_SHADOW = card_ui_atlas.find_region("512/card_super_shadow")
	#	CARD_COMMON_FRAME_LEFT = card_ui_atlas.find_region("512/common_left")
	#	CARD_COMMON_FRAME_MID = card_ui_atlas.find_region("512/common_center")
	#	CARD_COMMON_FRAME_RIGHT = card_ui_atlas.find_region("512/common_right")
	#	CARD_UNCOMMON_FRAME_LEFT = card_ui_atlas.find_region("512/uncommon_left")
	#	CARD_UNCOMMON_FRAME_MID = card_ui_atlas.find_region("512/uncommon_center")
	#	CARD_UNCOMMON_FRAME_RIGHT = card_ui_atlas.find_region("512/uncommon_right")
	#	CARD_RARE_FRAME_LEFT = card_ui_atlas.find_region("512/rare_left")
	#	CARD_RARE_FRAME_MID = card_ui_atlas.find_region("512/rare_center")
	#	CARD_RARE_FRAME_RIGHT = card_ui_atlas.find_region("512/rare_right")
	#	CARD_FLASH_VFX = card_ui_atlas.find_region("512/card_flash_vfx")

	card_attack_bg_purple_large = card_ui_atlas.find_region("1024/bg_attack_purple")
	card_skill_bg_purple_large = card_ui_atlas.find_region("1024/bg_skill_purple")
	card_power_bg_purple_large = card_ui_atlas.find_region("1024/bg_power_purple")
	card_purple_orb_large = card_ui_atlas.find_region("1024/card_purple_orb")

	card_attack_bg_red_large = card_ui_atlas.find_region("1024/bg_attack_red")
	card_skill_bg_red_large = card_ui_atlas.find_region("1024/bg_skill_red")
	card_power_bg_red_large = card_ui_atlas.find_region("1024/bg_power_red")
	card_red_orb_large = card_ui_atlas.find_region("1024/card_red_orb")

	card_attack_bg_green_large = card_ui_atlas.find_region("1024/bg_attack_green")
	card_skill_bg_green_large = card_ui_atlas.find_region("1024/bg_skill_green")
	card_power_bg_green_large = card_ui_atlas.find_region("1024/bg_power_green")
	card_green_orb_large = card_ui_atlas.find_region("1024/card_green_orb")

	card_attack_bg_blue_large = card_ui_atlas.find_region("1024/bg_attack_blue")
	card_skill_bg_blue_large = card_ui_atlas.find_region("1024/bg_power_blue")
	card_power_bg_blue_large = card_ui_atlas.find_region("1024/bg_skill_blue")
	card_blue_orb_large = card_ui_atlas.find_region("1024/card_blue_orb")

	card_attack_bg_colorless_large = card_ui_atlas.find_region("1024/bg_attack_colorless")
	card_skill_bg_colorless_large = card_ui_atlas.find_region("1024/bg_skill_colorless")
	card_power_bg_colorless_large = card_ui_atlas.find_region("1024/bg_power_colorless")
	card_colorless_orb_large = card_ui_atlas.find_region("1024/card_colorless_orb")
	#	
	card_skill_bg_black_large = card_ui_atlas.find_region("1024/bg_skill_black")

	card_frame_attack_common_large = card_ui_atlas.find_region("1024/frame_attack_common")
	card_frame_attack_uncommon_large = card_ui_atlas.find_region("1024/frame_attack_uncommon")
	card_frame_attack_rare_large = card_ui_atlas.find_region("1024/frame_attack_rare")
	card_frame_skill_common_large = card_ui_atlas.find_region("1024/frame_skill_common")
	card_frame_skill_uncommon_large = card_ui_atlas.find_region("1024/frame_skill_uncommon")
	card_frame_skill_rare_large = card_ui_atlas.find_region("1024/frame_skill_rare")
	card_frame_power_common_large = card_ui_atlas.find_region("1024/frame_power_common")
	card_frame_power_uncommon_large = card_ui_atlas.find_region("1024/frame_power_uncommon")
	card_frame_power_rare_large = card_ui_atlas.find_region("1024/frame_power_rare")
	card_banner_common_large = card_ui_atlas.find_region("1024/banner_common")
	card_banner_uncommon_large = card_ui_atlas.find_region("1024/banner_uncommon")
	card_banner_rare_large = card_ui_atlas.find_region("1024/banner_rare")
	
	#	CARD_LOCKED_ATTACK_L = card_ui_atlas.find_region("ocked_attack_l")
	#	CARD_LOCKED_SKILL_L = card_ui_atlas.find_region("ocked_skill_l")
	#	CARD_LOCKED_POWER_L = card_ui_atlas.find_region("ocked_power_l")
	#	CARD_COMMON_FRAME_LEFT_L = card_ui_atlas.find_region("1024/common_left")
	#	CARD_COMMON_FRAME_MID_L = card_ui_atlas.find_region("1024/common_center")
	#	CARD_COMMON_FRAME_RIGHT_L = card_ui_atlas.find_region("1024/common_right")
	#	CARD_UNCOMMON_FRAME_LEFT_L = card_ui_atlas.find_region("1024/uncommon_left")
	#	CARD_UNCOMMON_FRAME_MID_L = card_ui_atlas.find_region("1024/uncommon_center")
	#	CARD_UNCOMMON_FRAME_RIGHT_L = card_ui_atlas.find_region("1024/uncommon_right")
	#	CARD_RARE_FRAME_LEFT_L = card_ui_atlas.find_region("1024/rare_left")
	#	CARD_RARE_FRAME_MID_L = card_ui_atlas.find_region("1024/rare_center")
	#	CARD_RARE_FRAME_RIGHT_L = card_ui_atlas.find_region("1024/rare_right")
	

static func initialize_portrait_img() -> void:
	PORTRAIT_STANDARD = load("res://arts/slay_the_spire/images/ui/menu/portrait/standard.jpg")
	PORTRAIT_DAILY = load("res://arts/slay_the_spire/images/ui/menu/portrait/daily.jpg")
	PORTRAIT_LOOP = load("res://arts/slay_the_spire/images/ui/menu/portrait/loop.jpg")
	PORTRAIT_INFO_CARD = load("res://arts/slay_the_spire/images/ui/menu/portrait/card.jpg")
	PORTRAIT_INFO_RELIC = load("res://arts/slay_the_spire/images/ui/menu/portrait/relics.jpg")
	PORTRAIT_INFO_POTION = load("res://arts/slay_the_spire/images/ui/menu/portrait/potion.jpg")
	PORTRAIT_STAT_CHAR = load("res://arts/slay_the_spire/images/ui/menu/portrait/charstat.jpg")
	PORTRAIT_STAT_HISTORY = load("res://arts/slay_the_spire/images/ui/menu/portrait/history.jpg")
	PORTRAIT_STAT_LEADERBOARD = load("res://arts/slay_the_spire/images/ui/menu/portrait/leaderboards.jpg")
	PORTRAIT_SETTING_GAME = load("res://arts/slay_the_spire/images/ui/menu/portrait/gamesettings.jpg")
	PORTRAIT_SETTING_INPUT = load("res://arts/slay_the_spire/images/ui/menu/portrait/input_settings.jpg")
	PORTRAIT_SETTING_CREDITS = load("res://arts/slay_the_spire/images/ui/menu/portrait/credits.jpg")

static func initialize_panel_ui() -> void:
	# character select
	CHARACTER_SELECT_IRONCLAD = load("res://arts/slay_the_spire/images/ui/character_select/ironcladButton.png")
	CHARACTER_SELECT_SILENT = load("res://arts/slay_the_spire/images/ui/character_select/silentButton.png")
	CHARACTER_SELECT_DEFECT = load("res://arts/slay_the_spire/images/ui/character_select/defectButton.png")
	CHARACTER_SELECT_WATCHER = load("res://arts/slay_the_spire/images/ui/character_select/watcherButton.png")
	CHARACTER_SELECT_BG_IRONCLAD = load("res://arts/slay_the_spire/images/ui/character_select/ironcladPortrait.jpg")
	CHARACTER_SELECT_BG_SILENT = load("res://arts/slay_the_spire/images/ui/character_select/silentPortrait.jpg")
	CHARACTER_SELECT_BG_DEFECT = load("res://arts/slay_the_spire/images/ui/character_select/defectPortrait.jpg")
	CHARACTER_SELECT_BG_WATCHER = load("res://arts/slay_the_spire/images/ui/character_select/watcherPortrait.jpg")
	
	UI_GOLD = load("res://arts/slay_the_spire/images/ui/top_panel/gold.png")
	TP_HP = load("res://arts/slay_the_spire/images/ui/top_panel/panelHeart.png")
	TP_GOLD = load("res://arts/slay_the_spire/images/ui/top_panel/panelGoldBag.png")
	TP_FLOOR = load("res://arts/slay_the_spire/images/ui/top_panel/floor.png")
	TP_ASCENSION = load("res://arts/slay_the_spire/images/ui/top_panel/ascension.png")


static func initialize_map_ui() -> void:
	map_node_event = load("res://arts/slay_the_spire/images/ui/map/event.png")
	map_node_event_outline = load("res://arts/slay_the_spire/images/ui/map/eventOutline.png")
	map_node_elite = load("res://arts/slay_the_spire/images/ui/map/elite.png")
	map_node_elite_outline = load("res://arts/slay_the_spire/images/ui/map/eliteOutline.png")
	map_node_enemy = load("res://arts/slay_the_spire/images/ui/map/monster.png")
	map_node_enemy_outline = load("res://arts/slay_the_spire/images/ui/map/monsterOutline.png")
	map_node_rest = load("res://arts/slay_the_spire/images/ui/map/rest.png")
	map_node_rest_outline = load("res://arts/slay_the_spire/images/ui/map/restOutline.png")
	map_node_treasure = load("res://arts/slay_the_spire/images/ui/map/chest.png")
	map_node_treasure_outline = load("res://arts/slay_the_spire/images/ui/map/chestOutline.png")
	map_node_merchant = load("res://arts/slay_the_spire/images/ui/map/shop.png")
	map_node_merchant_outline = load("res://arts/slay_the_spire/images/ui/map/shopOutline.png")
	map_legend = load("res://arts/slay_the_spire/images/ui/map/legend2.png")

	map_dot = load("res://arts/slay_the_spire/images/ui/map/dot1.png")

static func initialize_enemy_ui() -> void:
	boss_level1_gurdian_img = load("res://arts/slay_the_spire/images/ui/map/boss/guardian.png")
	boss_level1_gurdian_outline = load("res://arts/slay_the_spire/images/ui/map/bossOutline/guardian.png")
	boss_level1_hexaghost_img = load("res://arts/slay_the_spire/images/ui/map/boss/hexaghost.png")
	boss_level1_hexaghost_outline = load("res://arts/slay_the_spire/images/ui/map/bossOutline/hexaghost.png")
	boss_level1_slime_img = load("res://arts/slay_the_spire/images/ui/map/boss/slime.png")
	boss_level1_slime_outline = load("res://arts/slay_the_spire/images/ui/map/bossOutline/slime.png")

	boss_level2_collector_img = load("res://arts/slay_the_spire/images/ui/map/boss/collector.png")
	boss_level2_collector_outline = load("res://arts/slay_the_spire/images/ui/map/bossOutline/collector.png")
	boss_level2_automaton_img = load("res://arts/slay_the_spire/images/ui/map/boss/automaton.png")
	boss_level2_automaton_outline = load("res://arts/slay_the_spire/images/ui/map/bossOutline/automaton.png")
	boss_level2_champ_img = load("res://arts/slay_the_spire/images/ui/map/boss/champ.png")
	boss_level2_champ_outline = load("res://arts/slay_the_spire/images/ui/map/bossOutline/champ.png")
	
	boss_level3_awakened_img = load("res://arts/slay_the_spire/images/ui/map/boss/awakened.png")
	boss_level3_awakened_outline = load("res://arts/slay_the_spire/images/ui/map/bossOutline/awakened.png")
	boss_level3_timeeater_img = load("res://arts/slay_the_spire/images/ui/map/boss/timeeater.png")
	boss_level3_timeeater_outline = load("res://arts/slay_the_spire/images/ui/map/bossOutline/timeeater.png")
	boss_level3_donu_img = load("res://arts/slay_the_spire/images/ui/map/boss/donu.png")
	boss_level3_donu_outline = load("res://arts/slay_the_spire/images/ui/map/bossOutline/donu.png")
	
	boss_level_end_heart_img = load("res://arts/slay_the_spire/images/ui/map/boss/heart.png")
	boss_level_end_heart_outline = load("res://arts/slay_the_spire/images/ui/map/bossOutline/heart.png")
	pass

static func loadPortraitImg(url: String) -> Texture2D:
	return load("res://arts/slay_the_spire/images/1024Portraits/" + url + ".png")

static func loadRelicImg(setId: String, imgName: String) -> void:
	if not relic_images.has(setId):
		relic_images.set(setId, load(AbstractRelic.IMG_DIR + imgName))
		relic_outline_images.set(setId, load(AbstractRelic.OUTLINE_DIR + imgName))

static func getRelicImg(setId: String) -> Texture2D:
	return relic_images[setId]

static func getRelicOutlineImg(setId: String) -> Texture2D:
	return relic_outline_images[setId]

static func get_boss_img(bossKey: String) -> Texture2D:
	match bossKey:
		MonsterHelper.BOSS_LEVEL1_SLIME:
			return boss_level1_slime_img
		MonsterHelper.BOSS_LEVEL1_GUARDIAN:
			return boss_level1_gurdian_img
		MonsterHelper.BOSS_LEVEL1_HEXAGHOST:
			return boss_level1_hexaghost_img
		MonsterHelper.BOSS_LEVEL2_AUTOMATON:
			return boss_level2_automaton_img
		MonsterHelper.BOSS_LEVEL2_CHAMP:
			return boss_level2_champ_img
		MonsterHelper.BOSS_LEVEL2_COLLECTOR:
			return boss_level2_collector_img
		MonsterHelper.BOSS_LEVEL3_AWAKENED_ONE:
			return boss_level3_awakened_img
		MonsterHelper.BOSS_LEVEL3_TIME_EATER:
			return boss_level3_timeeater_img
		MonsterHelper.BOSS_LEVEL3_DONU_AND_DECA:
			return boss_level3_donu_img
	push_error("{0} has not implemented.".format([bossKey]))
	return null

static func get_boss_img_outline(bossKey: String) -> Texture2D:
	match bossKey:
		MonsterHelper.BOSS_LEVEL1_SLIME:
			return boss_level1_slime_outline
		MonsterHelper.BOSS_LEVEL1_GUARDIAN:
			return boss_level1_gurdian_outline
		MonsterHelper.BOSS_LEVEL1_HEXAGHOST:
			return boss_level1_hexaghost_outline
		MonsterHelper.BOSS_LEVEL2_AUTOMATON:
			return boss_level2_automaton_outline
		MonsterHelper.BOSS_LEVEL2_CHAMP:
			return boss_level2_champ_outline
		MonsterHelper.BOSS_LEVEL2_COLLECTOR:
			return boss_level2_collector_outline
		MonsterHelper.BOSS_LEVEL3_AWAKENED_ONE:
			return boss_level3_awakened_outline
		MonsterHelper.BOSS_LEVEL3_TIME_EATER:
			return boss_level3_timeeater_outline
		MonsterHelper.BOSS_LEVEL3_DONU_AND_DECA:
			return boss_level3_donu_outline
	
	push_error("{0} has not implemented.".format([bossKey]))
	return null
