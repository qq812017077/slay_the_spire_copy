class_name BeyondScene
extends AbstractScene

const ATLAS_PATH = "res://arts/slay_the_spire/scenes/beyondScene/scene.atlas"

var bg1: AtlasRegion = null
var bg2: AtlasRegion = null
var flooring: AtlasRegion = null
var ceiling: AtlasRegion = null
var fg: AtlasRegion = null
var mg1: AtlasRegion = null
var mg2: AtlasRegion = null
var mg3: AtlasRegion = null
var mg4: AtlasRegion = null
var c1: AtlasRegion = null
var c2: AtlasRegion = null
var c3: AtlasRegion = null
var c4: AtlasRegion = null
var f1: AtlasRegion = null
var f2: AtlasRegion = null
var f3: AtlasRegion = null
var f4: AtlasRegion = null
var f5: AtlasRegion = null
var i1: AtlasRegion = null
var i2: AtlasRegion = null
var i3: AtlasRegion = null
var i4: AtlasRegion = null
var i5: AtlasRegion = null
var s1: AtlasRegion = null
var s2: AtlasRegion = null
var s3: AtlasRegion = null
var s4: AtlasRegion = null
var s5: AtlasRegion = null

func _init() -> void:
    super (ATLAS_PATH)

    ambiance_name = "AMBIANCE_BEYOND"
    
    bg1 = atlas.find_region("mod/bg1")
    bg2 = atlas.find_region("mod/bg2")
    flooring = atlas.find_region("mod/flooring")
    ceiling = atlas.find_region("mod/ceiling")
    fg = atlas.find_region("mod/fg")
    mg1 = atlas.find_region("mod/mod1")
    mg2 = atlas.find_region("mod/mod2")
    mg3 = atlas.find_region("mod/mod3")
    mg4 = atlas.find_region("mod/mod4")
    c1 = atlas.find_region("mod/c1")
    c2 = atlas.find_region("mod/c2")
    c3 = atlas.find_region("mod/c3")
    c4 = atlas.find_region("mod/c4")
    f1 = atlas.find_region("mod/f1")
    f2 = atlas.find_region("mod/f2")
    f3 = atlas.find_region("mod/f3")
    f4 = atlas.find_region("mod/f4")
    f5 = atlas.find_region("mod/f5")
    i1 = atlas.find_region("mod/i1")
    i2 = atlas.find_region("mod/i2")
    i3 = atlas.find_region("mod/i3")
    i4 = atlas.find_region("mod/i4")
    i5 = atlas.find_region("mod/i5")
    s1 = atlas.find_region("mod/s1")
    s2 = atlas.find_region("mod/s2")
    s3 = atlas.find_region("mod/s3")
    s4 = atlas.find_region("mod/s4")
    s5 = atlas.find_region("mod/s5")