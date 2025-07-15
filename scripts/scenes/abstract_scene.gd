class_name AbstractScene
extends Object

var bg_overlay_color: Color = Color(0, 0, 0, 0.0)
var bg_overlay_target: float = 0.0

var atlas: TextureAtlas = null
var bg: AtlasRegion = null

var compfire_bg: AtlasRegion = null
var comfire_glow: AtlasRegion = null
var comfire_kindling: AtlasRegion = null
var event: AtlasRegion = null

var ambiance_name: String = ""
func _init(atlas_url: String) -> void:
    atlas = TextureAtlas.load(atlas_url)
    bg = atlas.find_region("bg")
    compfire_bg = atlas.find_region("campfire")
    comfire_glow = atlas.find_region("mod/campfireGlow")
    comfire_kindling = atlas.find_region("mod/campfireKindling")
    event = atlas.find_region("event")
#########################################################################
# Static functions
#########################################################################
static func initialize():
    pass