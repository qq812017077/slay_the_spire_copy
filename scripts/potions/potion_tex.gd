class_name PotionTex
extends Object

var container_tex: Texture2D = null
var liquid_tex: Texture2D = null
var hybrid_tex: Texture2D = null
var spots_tex: Texture2D = null
var outline_tex: Texture2D = null


static func create_glass_potion(dir: String, pre_suffix: String = "") -> PotionTex:
    var potion_tex = PotionTex.new()
    potion_tex.container_tex = load(dir + pre_suffix + "glass.png")
    potion_tex.liquid_tex = load(dir + pre_suffix + "liquid.png")
    potion_tex.hybrid_tex = load(dir + pre_suffix + "hybrid.png")
    potion_tex.spots_tex = load(dir + pre_suffix + "spots.png")
    potion_tex.outline_tex = load(dir + pre_suffix + "outline.png")

    return potion_tex

static func create_body_potion(dir: String, pre_suffix: String = "") -> PotionTex:
    var potion_tex: PotionTex = PotionTex.new()
    # if has file
    if FileAccess.file_exists(dir + pre_suffix + "body.png"):
        potion_tex.container_tex = load(dir + pre_suffix + "body.png")
    if FileAccess.file_exists(dir + pre_suffix + "liquid.png"):
        potion_tex.liquid_tex = load(dir + pre_suffix + "liquid.png")
    if FileAccess.file_exists(dir + pre_suffix + "hybrid.png"):
        potion_tex.hybrid_tex = load(dir + pre_suffix + "hybrid.png")
    if FileAccess.file_exists(dir + pre_suffix + "spots.png"):
        potion_tex.spots_tex = load(dir + pre_suffix + "spots.png")
    if FileAccess.file_exists(dir + pre_suffix + "outline.png"):
        potion_tex.outline_tex = load(dir + pre_suffix + "outline.png")
    return potion_tex