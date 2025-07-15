class_name BottomScene
extends AbstractScene

const ATLAS_PATH = "res://arts/slay_the_spire/scenes/bottomScene/scene.atlas"

var fg: AtlasRegion = null
var mg: AtlasRegion = null
var left_wall: AtlasRegion = null
var hollow_wall: AtlasRegion = null
var solid_wall: AtlasRegion = null


var ceiling: AtlasRegion = null
var ceilingMod1: AtlasRegion = null
var ceilingMod2: AtlasRegion = null
var ceilingMod3: AtlasRegion = null
var ceilingMod4: AtlasRegion = null
var ceilingMod5: AtlasRegion = null
var ceilingMod6: AtlasRegion = null

func _init() -> void:
    super (ATLAS_PATH)

    ambiance_name = "AMBIANCE_BOTTOM"
    
    fg = atlas.find_region("mod/fg");
    mg = atlas.find_region("mod/mg");
    left_wall = atlas.find_region("mod/mod1");
    hollow_wall = atlas.find_region("mod/mod2");
    solid_wall = atlas.find_region("mod/midWall");
  
    ceiling = atlas.find_region("mod/ceiling");
    ceilingMod1 = atlas.find_region("mod/ceilingMod1");
    ceilingMod2 = atlas.find_region("mod/ceilingMod2");
    ceilingMod3 = atlas.find_region("mod/ceilingMod3");
    ceilingMod4 = atlas.find_region("mod/ceilingMod4");
    ceilingMod5 = atlas.find_region("mod/ceilingMod5");
    ceilingMod6 = atlas.find_region("mod/ceilingMod6");