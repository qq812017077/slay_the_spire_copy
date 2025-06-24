class_name ImageMaster
extends Object

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

static var card_skill_bg_black_large: AtlasRegion = null
static var card_blue_orb_large: AtlasRegion = null

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


static func initialize() -> void:
	initialize_card_ui()
	

	
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

	#	CARD_ATTACK_BG_GRAY_L = card_ui_atlas.find_region("1024/bg_attack_colorless")
	#	CARD_SKILL_BG_GRAY_L = card_ui_atlas.find_region("1024/bg_skill_colorless")
	#	CARD_POWER_BG_GRAY_L = card_ui_atlas.find_region("1024/bg_power_colorless")
	#	CARD_GRAY_ORB_L = card_ui_atlas.find_region("1024/card_colorless_orb")
	#	
	card_skill_bg_black = card_ui_atlas.find_region("1024/bg_skill_black")

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
	