class_name CityScene
extends AbstractScene

const ATLAS_PATH = "res://arts/slay_the_spire/scenes/cityScene/scene.atlas"

var bgGlow: AtlasRegion = null
var bgGlow2: AtlasRegion = null
var bg2: AtlasRegion = null
var bg2Glow: AtlasRegion = null
var floor_region: AtlasRegion = null
var ceiling: AtlasRegion = null
var wall: AtlasRegion = null
var chains: AtlasRegion = null
var chainsGlow: AtlasRegion = null
var pillar1: AtlasRegion = null
var pillar2: AtlasRegion = null
var pillar3: AtlasRegion = null
var pillar4: AtlasRegion = null
var pillar5: AtlasRegion = null
var throne: AtlasRegion = null
var throneGlow: AtlasRegion = null
var mg: AtlasRegion = null
var mgGlow: AtlasRegion = null
var mg2: AtlasRegion = null
var fg: AtlasRegion = null
var fgGlow: AtlasRegion = null
var fg2: AtlasRegion = null

func _init() -> void:
    super (ATLAS_PATH)

    ambiance_name = "AMBIANCE_CITY"
    bg = atlas.find_region("mod/bg1")
    bgGlow = atlas.find_region("mod/bgGlowv2")
    bgGlow2 = atlas.find_region("mod/bgGlowBlur")
    bg2 = atlas.find_region("mod/bg2")
    bg2Glow = atlas.find_region("mod/bg2Glow")
    floor_region = atlas.find_region("mod/floor_region")
    ceiling = atlas.find_region("mod/ceiling")
    wall = atlas.find_region("mod/wall")
    chains = atlas.find_region("mod/chains")
    chainsGlow = atlas.find_region("mod/chainsGlow")
    pillar1 = atlas.find_region("mod/p1")
    pillar2 = atlas.find_region("mod/p2")
    pillar3 = atlas.find_region("mod/p3")
    pillar4 = atlas.find_region("mod/p4")
    pillar5 = atlas.find_region("mod/p5")
    throne = atlas.find_region("mod/throne")
    throneGlow = atlas.find_region("mod/throneGlow")
    mg = atlas.find_region("mod/mg1")
    mgGlow = atlas.find_region("mod/mg1Glow")
    mg2 = atlas.find_region("mod/mg2")
    fg = atlas.find_region("mod/fg")
    fgGlow = atlas.find_region("mod/fgGlow")
    fg2 = atlas.find_region("mod/fgHideWindow")